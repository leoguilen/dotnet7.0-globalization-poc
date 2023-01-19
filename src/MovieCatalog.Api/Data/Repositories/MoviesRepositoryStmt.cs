namespace MovieCatalog.Api.Data.Repositories;

internal static class MoviesRepositoryStmt
{
    public const string SelectAllSqlQuery = @"
        WITH base_resultset AS (
            SELECT
                m.""Id"",
                m.""NavigationId"",
                m.""Title"",
                m.""Synopsis"",
                m.""Director"",
                m.""ReleaseYear"",
                gt.""Id"" AS ""GenreTypeId"",
                gt.""NavigationId"" AS ""GenreTypeNavigationId"",
                gt.""Description"" AS ""GenreTypeDescription""
            FROM ""Movies"" m
            INNER JOIN ""GenreTypes"" gt
                ON m.""GenreId"" = gt.""Id""
        ), translated_resultset AS (
            SELECT
                base.""Id"",
                base.""NavigationId"",
                COALESCE(md.""Title"", base.""Title"") AS ""Title"",
                COALESCE(md.""Synopsis"", base.""Synopsis"") AS ""Synopsis"",
                base.""Director"",
                base.""ReleaseYear"",
                base.""GenreTypeId"",
                base.""GenreTypeNavigationId"",
                COALESCE(gtd.""Description"", base.""GenreTypeDescription"") AS ""GenreTypeDescription""
            FROM base_resultset base
            LEFT JOIN ""MoviesDictionary"" md
                ON base.""Id"" = md.""MovieId"" AND md.""Culture"" = @Culture
            LEFT JOIN ""GenreTypesDictionary"" gtd
                ON base.""GenreTypeId"" = gtd.""GenreId"" AND gtd.""Culture"" = @Culture
        )
        SELECT *
        FROM translated_resultset
        ORDER BY ""Id""";

    public const string SelectOneSqlQuery = @"
        SELECT
            m.""Id"",
            m.""NavigationId"",
            COALESCE(md.""Title"", m.""Title"") AS ""Title"",
            COALESCE(md.""Synopsis"", m.""Synopsis"") AS ""Synopsis"",
            m.""Director"",
            m.""ReleaseYear"",
            gt.""Id"" AS ""GenreTypeId"",
            gt.""NavigationId"" AS ""GenreTypeNavigationId"",
            COALESCE(gtd.""Description"", gt.""Description"") AS ""GenreTypeDescription""
        FROM (SELECT * FROM ""Movies"" WHERE ""NavigationId"" = @MovieId) m
        INNER JOIN ""GenreTypes"" gt
            ON m.""GenreId"" = gt.""Id""
        LEFT JOIN ""MoviesDictionary"" md
            ON m.""Id"" = md.""MovieId"" AND md.""Culture"" = @Culture
        LEFT JOIN ""GenreTypesDictionary"" gtd
            ON gt.""Id"" = gtd.""GenreId"" AND gtd.""Culture"" = @Culture";
}