namespace MovieCatalog.Api.Models;

public readonly record struct GenreType
{
    public int Id { get; init; }

    public Guid NavigationId { get; init; }

    public string Description { get; init; }
}