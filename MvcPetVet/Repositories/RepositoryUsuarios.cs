using Microsoft.EntityFrameworkCore;
using MvcPetVet.Helpers;
using MvcPetVet.Data;
using MvcPetVet.Models;

#region TABLES

//CREATE VIEW V_TRATAMIENTOS
//AS
//	SELECT IDTRATAMIENTO, TRATAMIENTOS.IDUSUARIO, TRATAMIENTOS.IDMASCOTA, NMASCOTA, NOMBREMEDICACION, DOSIS, DURACION, DESCRIPCION
//	FROM TRATAMIENTOS
//	LEFT JOIN MASCOTAS
//	ON TRATAMIENTOS.IDMASCOTA = MASCOTAS.IDMASCOTA
//GO

//CREATE VIEW V_CITAS
//AS
//	SELECT IDCITA, CITAS.IDUSUARIO, CITAS.IDMASCOTA, NMASCOTA, TIPO_CITA, DIA_CITA
//	FROM CITAS
//	LEFT JOIN MASCOTAS
//	ON CITAS.IDMASCOTA = MASCOTAS.IDMASCOTA
//GO

//create table MASCOTAS(
//	IDMASCOTA int primary key,
//    NMASCOTA nvarchar(50),
//	EDAD int,
//	PESO int,
//	RAZA nvarchar(50),
//	IDUSUARIO int
//)

//create table CITAS(
//	IDCITA int primary key,
//    IDUSUARIO int,
//    IDMASCOTA int,
//    TIPO_CITA NVARCHAR(50),
//	DIA_CITA DATETIME
//)


//CREATE TABLE TRATAMIENTOS(
//IDTRATAMIENTO INT PRIMARY KEY,
//IDUSUARIO INT,
//IDMASCOTA INT,
//NOMBREMEDICACION NVARCHAR(75),
//DOSIS NVARCHAR(20),
//DURACION NVARCHAR(50),
//DESCRIPCION NVARCHAR(100)
//)

//create TABLE USUARIOS (
//	IDUSUARIO INT PRIMARY KEY,
//    APODO NVARCHAR(50) NOT NULL,
//    NOMBRE NVARCHAR(50),
//    TELEFONO NVARCHAR(15),
//	  EMAIL NVARCHAR(150) UNIQUE NOT NULL,
//    SALT NVARCHAR(MAX) NOT NULL,
//    PASS NVARCHAR(50) NOT NULL,
//    PASS_CIFRADA NVARCHAR(MAX) NOT NULL,
//    IMAGEN NVARCHAR(MAX) DEFAULT 'default_image.jpg'
//)

#endregion

#region PROCEDURES

#endregion

namespace MvcPetVet.Repositories
{
    public class RepositoryUsuarios
    {
        private UsuariosContext context;

        public RepositoryUsuarios(UsuariosContext context)
        {
            this.context = context;
        }

        private int GetMaxIdUsuario()
        {
            if (this.context.Usuarios.Count() == 0)
            {
                return 1;
            }
            else
            {
                return this.context.Usuarios.Max(z => z.IdUsuario) + 1;
            }
        }

        

        public async Task RegisterUser(string apodo
            , string email, string password)
        {
            Usuario user = new Usuario();
            user.IdUsuario = this.GetMaxIdUsuario();
            user.Apodo = apodo;
            user.Nombre = "";
            user.Email = email;
            user.Telefono = "";
            user.Pass = password;
            user.Imagen = "default_img.webp";
            

            //user.Imagen = imagen;
            //CADA USUARIO TENDRA UN SALT DIFERENTE
            user.Salt =
                HelperCryptography.GenerateSalt();

            //CIFRAMOS EL PASSWORD DEL USUARIO CON SU SALT
            user.Password =
                HelperCryptography.EncryptPassword(password, user.Salt);
            this.context.Usuarios.Add(user);
            await this.context.SaveChangesAsync();
        }

        public async Task<Usuario> UpdateUsuario(int idusuario, string nombre, string apodo,
            string email, string telefono)
        {
            Usuario user = await FindUserAsync(idusuario);
            user.Nombre = nombre;
            user.Apodo = apodo;
            user.Email = email;
            user.Telefono = telefono;

            this.context.Usuarios.Update(user);
            await this.context.SaveChangesAsync();
            return user;
        }

        public async Task<Usuario> UpdateUsuario(int idusuario, string nombre, string apodo,
            string email, string telefono, string fileName)
        {
            Usuario user = await FindUserAsync(idusuario);
            user.Nombre = nombre;
            user.Apodo = apodo;
            user.Email = email;
            user.Telefono = telefono;
            user.Imagen = fileName;

            this.context.Usuarios.Update(user);
            await this.context.SaveChangesAsync();
            return user;
        }


        public async Task<Usuario> FindUserAsync(int idusuario)
		{
			return await
				this.context.Usuarios
				.FirstOrDefaultAsync(x => x.IdUsuario == idusuario);
		}

		public async Task<Usuario> ExisteUsuario
            (string username, string password)
        {
            Usuario user = new Usuario();

            if (username.IndexOf("@") != -1)
            {
                user = await
                this.context.Usuarios.FirstOrDefaultAsync(x => x.Email == username);

            }
            else
            {
                user = await
                this.context.Usuarios.FirstOrDefaultAsync(x => x.Apodo == username);
            }


            if (user == null)
            {
                return null;
            }
            else
            {
                //RECUPERAMOS EL PASSWORD CIFRADO DE LA BBDD
                byte[] passUsuario = user.Password;
                //DEBEMOS CIFRAR DE NUEVO EL PASSWORD DE USUARIO
                //JUNTO A SU SALT UTILIZANDO LA MISMA TECNICA
                string salt = user.Salt;
                byte[] temp =
                    HelperCryptography.EncryptPassword(password, salt);

                //COMPARAMOS LOS DOS ARRAYS
                bool respuesta =
                    HelperCryptography.CompareArrays(passUsuario, temp);
                if (respuesta == true)
                {
                    //SON IGUALES
                    return user;
                }
                else
                {
                    return null;
                }
            }
        }

        public List<Mascota> GetMascotas(int idusuario)
        {
            List<Mascota> mascotas = this.context.Mascotas.Where( x => x.IdUsuario == idusuario).ToList();
            return mascotas;
        }


        public List<Cita> GetCitas(int idusuario)
        {
            List<Cita> citas = this.context.Citas.ToList();
            List<Cita> citasUsuario = new List<Cita>();

            foreach (Cita cita in citas)
            {
                if (cita.IdUsuario == idusuario)
                {
                    citasUsuario.Add(cita);
                }
            }

            return citasUsuario;
        }
    }
}
