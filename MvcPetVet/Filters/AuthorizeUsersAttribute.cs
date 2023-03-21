using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;

namespace MvcCoreSeguridadPersonalizada.Filters
{
    public class AuthorizeUsersAttribute : AuthorizeAttribute
        , IAuthorizationFilter
    {
        public void OnAuthorization(AuthorizationFilterContext context)
        {
            //AQUI ES DONDE ENTRAREMOS EN JUEGO ENTA LAS PETICIONES
            //DE VIEWS Y CONTROLLERS
            //EL METODO IMPEDIRA ENTRAR EN CIERTOS LUGARES
            //CON MIS PREGUNTAS, DEBO CAMBIAR LA DIRECCION
            //DE ACCESO (LOGIN)
            //EL USUARIO SE ALMACENA DENTRO DE HttpContext
            //Y LA PROPIEDAD User
            //UN USUARIO ESTA COMPUESTO POR IDENTITY Y UN PRINCIPAL
            //MEDIANTE LA IDENTIDAD PODEMOS SABEER EL NAME DEL USUARIO
            //MEDIANTE E PRINIPAL PODEMOS PREGUNTAR POR EL ROLE

            var user = context.HttpContext.User;
            if(user.Identity.IsAuthenticated == false)
            {
                //AQUI DENTRO NO NOS GUSTA QUE NO SE HAYA AUTENTTIFICADO
                //Y LO LLEVAMOS AL LOGIN
                RouteValueDictionary rutaLogin =
                    new RouteValueDictionary
                    (
                        new {controller = "Usuarios", action = "Login"}
                        );
                //REDIRECCIONAMOS
                context.Result =
                    new RedirectToRouteResult(rutaLogin);
            }
        }
    }
}
