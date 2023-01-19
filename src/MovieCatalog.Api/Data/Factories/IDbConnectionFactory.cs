using System.Data;

namespace MovieCatalog.Api.Data.Factories;

public interface IDbConnectionFactory
{
    IDbConnection Build();
}
