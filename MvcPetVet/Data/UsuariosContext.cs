using Microsoft.EntityFrameworkCore;
using MvcPetVet.Models;
using System.Collections.Generic;

namespace MvcPetVet.Data
{
    public class UsuariosContext : DbContext
    {
        public UsuariosContext(DbContextOptions<UsuariosContext> options)
            : base(options) { }
        public DbSet<Usuario> Usuarios { get; set; }
        public DbSet<Mascota> Mascotas { get; set; }
        public DbSet<Tratamiento> Tratamientos { get; set; }
        public DbSet<Cita> Citas { get; set; }
    }
}
