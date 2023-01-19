namespace MovieCatalog.Api.Models;

public readonly record struct Movie
{
    public int Id { get; init; }

    public Guid NavigationId { get; init; }

    public string Title { get; init; }

    public string Synopsis { get; init; }

    public string Director { get; init; }

    public int ReleaseYear { get; init; }

    public GenreType GenreType { get; init; }
}
