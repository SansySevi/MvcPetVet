using MvcCryptographyBBDD.Helpers;
using MvcPetVet.Data;
using MvcPetVet.Models;

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
            user.Email = email;
            user.Pass = password;

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
            (string email, string password)
        {
            //List<Usuario> users = new List<Usuario>();
            //users = this.context.Usuarios.ToList();

            Usuario user =
                this.context.Usuarios.FirstOrDefault(z => z.Email == email);
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
    }
}
