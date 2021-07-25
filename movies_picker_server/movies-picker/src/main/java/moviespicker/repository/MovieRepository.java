package moviespicker.repository;

import moviespicker.model.Language;
import moviespicker.model.Location;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import moviespicker.model.Movie;

import java.util.List;

@Repository
public interface MovieRepository extends JpaRepository<Movie, Long>, JpaSpecificationExecutor<Movie> {
    String FIND_BY_TITLE_LANGUAGE_LOCATION =
            "SELECT x FROM Movie x WHERE x.title LIKE %:title% AND x.language IN (:languages) AND x.location IN (:locations) LIMIT 100";

    @Query(FIND_BY_TITLE_LANGUAGE_LOCATION)
    List<Movie> findByTitleLanguageLocation(
            @Param("title") String title,
            @Param("languages") List<Language> languages,
            @Param("locations") List<Location> locations);
}
