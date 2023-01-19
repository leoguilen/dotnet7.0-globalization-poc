using MovieCatalog.Api.Models;

namespace MovieCatalog.Api.Contracts.Responses;

public readonly record struct MovieResponse(
    Guid Id,
    string Title,
    string Synopsis,
    string Director,
    int ReleaseYear,
    GenreTypeResponse GenreType)
{
    public static MovieResponse From(Movie movie)
        => new(movie.NavigationId, movie.Title, movie.Synopsis, movie.Director, movie.ReleaseYear, GenreTypeResponse.From(movie.GenreType));
}
