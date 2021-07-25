package moviespicker.controller;

import moviespicker.model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import moviespicker.exception.MovieNotFoundException;
import moviespicker.repository.MovieRepository;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/v1")
public class MovieController {
	@Autowired
	private MovieRepository movieRepository;

	@GetMapping("/movies")
	public List<MoviePosterDTO> getMovies(
			@RequestParam(value = "title", required = false) String title,
			@RequestParam(value = "language", required = false) String language,
			@RequestParam(value = "location", required = false) String location) {
		String mTitle = title == null ? "" : title;
		List<Language> languages = language == null ? Arrays.asList(Language.values()) :
				Collections.singletonList(Language.parse(language));
		List<Location> locations = location == null ? Arrays.asList(Location.values()) :
				Collections.singletonList(Location.parse(location));
		List<Movie> movies = movieRepository.findByTitleLanguageLocation(
				mTitle, languages, locations);
		return movies.stream().map(this::buildMoviePosterDTO).collect(Collectors.toList());
	}

	private MoviePosterDTO buildMoviePosterDTO(Movie movie) {
		return new MoviePosterDTO(movie.getId(), movie.getPoster(), movie.getListingType());
	}

	@GetMapping("/movies/{id}")
	public ResponseEntity<MovieDetailsDTO> getMovie(
			@PathVariable(value = "id") Long movieId)
			throws MovieNotFoundException {
		Movie movie = movieRepository.findById(movieId)
				.orElseThrow(() -> new MovieNotFoundException(movieId));
		MovieDetailsDTO dto = new MovieDetailsDTO(movie.getId(),
				movie.getLanguage(), movie.getLocation(), movie.getPlot(),
				movie.getPoster(), splitCommaSeparatedList(movie.getSoundEffects()),
				splitCommaSeparatedList(movie.getStills()), movie.getTitle(),
				movie.getImdbID(), movie.getImdbRating(), movie.getListingType());
		return ResponseEntity.ok().body(dto);
	}

	private List<String> splitCommaSeparatedList(String s) {
		return Arrays.asList(s.split(","));
	}
}
