using Npgsql;
using System.Data;

namespace MovieCatalog.Api.Data.Factories.Impl;

internal sealed class NpgsqlConnectionFactory : IDbConnectionFactory
{
    private readonly string _connectionString;

    public NpgsqlConnectionFactory(string connectionString)
        => _connectionString = connectionString;

    public IDbConnection Build() => new NpgsqlConnection(_connectionString);
}
