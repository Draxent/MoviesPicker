package moviespicker.controller;

import moviespicker.model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import moviespicker.exception.MovieNotFoundException;
import moviespicker.repository.MovieRepository;

import java.util.Arrays;
import java.util.List;

@RestController
@RequestMapping("/api/v1")
public class MovieController {
	@Autowired
	private MovieRepository movieRepository;

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
