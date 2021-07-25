package moviespicker.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.NOT_FOUND)
public class MovieNotFoundException extends Exception{

	private static final long serialVersionUID = 1L;

	public MovieNotFoundException(Long movieId){
    	super(String.format("Cannot find movie with id %s", movieId));
    }
}
