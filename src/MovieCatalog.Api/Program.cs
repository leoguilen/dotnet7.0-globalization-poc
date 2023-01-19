using Microsoft.AspNetCore.Http.Features;
using Microsoft.AspNetCore.Localization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using MovieCatalog.Api.Contracts.Responses;
using MovieCatalog.Api.Data.Factories;
using MovieCatalog.Api.Data.Factories.Impl;
using MovieCatalog.Api.Data.Repositories;
using MovieCatalog.Api.Models;
using MovieCatalog.Api.Repositories;

var builder = WebApplication.CreateBuilder(args);

builder.Services
    .AddEndpointsApiExplorer()
    .AddSwaggerGen();

builder.Services
    .AddHttpContextAccessor()
    .AddLocalization()
    .Configure<RequestLocalizationOptions>(options =>
    {
        options
            .SetDefaultCulture("en-US")
            .AddSupportedCultures("en-US", "pt-BR", "es-ES");
        options.ApplyCurrentCultureToResponseHeaders = true;
        options.RequestCultureProviders.Clear();
        options.RequestCultureProviders.Add(new AcceptLanguageHeaderRequestCultureProvider());
    })
    .AddScoped(provider =>
    {
        var httpContextAccessor = provider.GetRequiredService<IHttpContextAccessor>();
        var requestCultureFeature = httpContextAccessor
            .HttpContext!
            .Features
            .GetRequiredFeature<IRequestCultureFeature>();

        return requestCultureFeature.RequestCulture;
    })
    .AddSingleton<IDbConnectionFactory>(_ => new NpgsqlConnectionFactory(builder.Configuration.GetConnectionString("Default")!))
    .AddScoped<IMoviesRepository, MoviesRepository>();

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

var localizationOptions = app.Services.GetRequiredService<IOptions<RequestLocalizationOptions>>()!.Value;
app.UseRequestLocalization(localizationOptions);

var apiGroup = app.MapGroup("/api");

apiGroup
    .MapGet("culture", ([FromServices] RequestCulture requestCulture)
        => Results.Ok(new
        {
            CurrentCultureName = requestCulture.Culture.Name,
            DateTimeFormat = requestCulture.Culture.DateTimeFormat.ShortDatePattern,
        }))
    .WithName("GetRequestCulture")
    .WithOpenApi();

apiGroup
    .MapGet("movies", async ([FromServices] IMoviesRepository movies)
        => Results.Ok((await movies.GetAllAsync()).Select(MovieResponse.From)))
    .WithName("GetAllMovies")
    .WithOpenApi();

apiGroup
    .MapGet("movies/{movieId:guid}", async ([FromRoute] Guid movieId, [FromServices] IMoviesRepository movies)
        => await movies.GetByIdAsync(movieId) switch
        {
            null => Results.NotFound(),
            Movie movie => Results.Ok(MovieResponse.From(movie)),
        })
    .WithName("GetOneMovie")
    .WithOpenApi();

await app.RunAsync();
