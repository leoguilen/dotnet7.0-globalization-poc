using Microsoft.AspNetCore.Localization;
using MovieCatalog.Api.Data.Factories;
using MovieCatalog.Api.Models;
using MovieCatalog.Api.Repositories;
using Npgsql;
using System.Data;

namespace MovieCatalog.Api.Data.Repositories;

internal sealed class MoviesRepository : IMoviesRepository
{
    private readonly IDbConnectionFactory _connectionFactory;
    private readonly RequestCulture _requestCulture;

    public MoviesRepository(
        IDbConnectionFactory connectionFactory,
        RequestCulture requestCulture)
    {
        _connectionFactory = connectionFactory;
        _requestCulture = requestCulture;
    }

    public async Task<IEnumerable<Movie>> GetAllAsync()
    {
        using var connection = _connectionFactory.Build();
        using var command = connection.CreateCommand();

        command.CommandText = MoviesRepositoryStmt.SelectAllSqlQuery;
        command.CommandType = CommandType.Text;
        command.Parameters.Add(new NpgsqlParameter("@Culture", _requestCulture.Culture.Name));

        if (connection.State is not ConnectionState.Open)
        {
            connection.Open();
        }

        using var resultSetReader = command.ExecuteReader(CommandBehavior.SingleResult | CommandBehavior.CloseConnection) as NpgsqlDataReader;

        if (!resultSetReader!.HasRows)
        {
            return Enumerable.Empty<Movie>();
        }

        var moviesRecords = new List<Movie>(capacity: 0);
        while (await resultSetReader.ReadAsync())
        {
            moviesRecords.EnsureCapacity(moviesRecords.Count + 1);
            moviesRecords.Add(new()
            {
                Id = resultSetReader.GetInt32(0),
                NavigationId = resultSetReader.GetGuid(1),
                Title = resultSetReader.GetString(2),
                Synopsis = resultSetReader.GetString(3),
                Director = resultSetReader.GetString(4),
                ReleaseYear = resultSetReader.GetInt32(5),
                GenreType = new()
                {
                    Id = resultSetReader.GetInt32(6),
                    NavigationId = resultSetReader.GetGuid(7),
                    Description = resultSetReader.GetString(8),
                },
            });
        }

        return moviesRecords;
    }

    public async Task<Movie?> GetByIdAsync(Guid movieId)
    {
        using var connection = _connectionFactory.Build();
        using var command = connection.CreateCommand();

        command.CommandText = MoviesRepositoryStmt.SelectOneSqlQuery;
        command.CommandType = CommandType.Text;
        command.Parameters.Add(new NpgsqlParameter("@Culture", _requestCulture.Culture.Name));
        command.Parameters.Add(new NpgsqlParameter("@MovieId", movieId));

        if (connection.State is not ConnectionState.Open)
        {
            connection.Open();
        }

        using var resultSetReader = command.ExecuteReader(CommandBehavior.SingleResult | CommandBehavior.CloseConnection) as NpgsqlDataReader;

        return !resultSetReader!.HasRows || !await resultSetReader.ReadAsync()
            ? null
            : new()
            {
                Id = resultSetReader.GetInt32(0),
                NavigationId = resultSetReader.GetGuid(1),
                Title = resultSetReader.GetString(2),
                Synopsis = resultSetReader.GetString(3),
                Director = resultSetReader.GetString(4),
                ReleaseYear = resultSetReader.GetInt32(5),
                GenreType = new()
                {
                    Id = resultSetReader.GetInt32(6),
                    NavigationId = resultSetReader.GetGuid(7),
                    Description = resultSetReader.GetString(8),
                },
            };
    }
}
