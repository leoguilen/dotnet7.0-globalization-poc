using MovieCatalog.Api.Models;

namespace MovieCatalog.Api.Contracts.Responses;

public readonly record struct GenreTypeResponse(Guid Id, string Description)
{
    public static GenreTypeResponse From(GenreType genreType)
        => new(genreType.NavigationId, genreType.Description);
}