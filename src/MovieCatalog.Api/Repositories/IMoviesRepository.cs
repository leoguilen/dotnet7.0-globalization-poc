using MovieCatalog.Api.Models;

namespace MovieCatalog.Api.Repositories;

public interface IMoviesRepository
{
    Task<IEnumerable<Movie>> GetAllAsync();

    Task<Movie?> GetByIdAsync(Guid movieId);
}
