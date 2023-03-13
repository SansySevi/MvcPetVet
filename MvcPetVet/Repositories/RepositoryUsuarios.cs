﻿using MvcCryptographyBBDD.Helpers;
using MvcPetVet.Data;
using MvcPetVet.Models;

#region TABLES

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


//create TABLE USUARIOS (
//	IDUSUARIO INT PRIMARY KEY,
//    APODO NVARCHAR(50) NOT NULL,
//    NOMBRE NVARCHAR(50),
//	EMAIL NVARCHAR(150) UNIQUE NOT NULL,
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
            user.Pass = password;
            user.Imagen = "default_img.png";

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

        public Usuario LogInUser
            (string log, string password)
        {

            Usuario user = new Usuario();

            if(log.IndexOf("@") != -1)
            {
                user =
                this.context.Usuarios.FirstOrDefault(z => z.Email == log);
            } else
            {
                user =
                this.context.Usuarios.FirstOrDefault(z => z.Apodo == log);
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

        public List<Cita> GetCitas(int idusuario)
        {
            List<Cita> citas = this.context.Citas.ToList();
            List<Cita> citasUsuario = new List<Cita>();

            foreach(Cita cita in citas)
            {
                if(cita.IdUsuario == idusuario)
                {
                    citasUsuario.Add(cita);
                }
            }

            return citasUsuario;
        }
    }
}
