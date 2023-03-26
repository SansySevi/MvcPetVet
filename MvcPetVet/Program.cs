using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.EntityFrameworkCore;
using MvcPetVet.Helpers;
using MvcPetVet.Data;
using MvcPetVet.Repositories;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

//SEGURIDAD 
builder.Services.AddAuthentication(options => {
    options.DefaultSignInScheme =
    CookieAuthenticationDefaults.AuthenticationScheme;
    options.DefaultAuthenticateScheme =
    CookieAuthenticationDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme =
    CookieAuthenticationDefaults.AuthenticationScheme;
}).AddCookie();


// BASE DE DATOS
string connectionString =
    builder.Configuration.GetConnectionString("SqlVetCareAzure");

builder.Services.AddHttpContextAccessor();
builder.Services.AddSingleton<IHttpContextAccessor, HttpContextAccessor>();


builder.Services.AddTransient<RepositoryUsuarios>();

builder.Services.AddSingleton<HelperPathProvider>();
builder.Services.AddSingleton<HelperCryptography>();
builder.Services.AddSingleton<HelperClaims>();
builder.Services.AddSingleton<HelperJson>();

builder.Services.AddDbContext<UsuariosContext>
    (options => options.UseSqlServer(connectionString));


//INDICAMOS QUE UTILIZAMOS NUESTRAR PROPIAS RUTAS
//DE VALIDACION
builder.Services.AddControllersWithViews
    (options => options.EnableEndpointRouting = false);
var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();
app.UseAuthentication();
app.UseAuthorization();

app.UseMvc(routes =>
{
    routes.MapRoute(
        name: "Default",
        template: "{controller=Home}/{action=Index}/{id?}");
});

app.Run();
