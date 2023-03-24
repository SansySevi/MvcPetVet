namespace MvcPetVet.Helpers
{   
    public enum Folders {Images = 0, Uploads = 1, Usuarios = 2, Mascotas = 3, Temporal }

    public class HelperPathProvider
    {   

        private IWebHostEnvironment hostEnvironment;

        public HelperPathProvider(IWebHostEnvironment hostEnvironment) 
        { 
            this.hostEnvironment = hostEnvironment;
        
        }

        public string MapPath(string fileName, Folders folder)
        {
            string carpeta = "";
            if(folder == Folders.Images) 
            {
                carpeta = "images";
            
            }else if(folder == Folders.Uploads)
            {
                carpeta = "ficheros";
            }
            else if (folder == Folders.Usuarios)
            {
                carpeta = "usuarios";

            }
            else if (folder == Folders.Mascotas)
            {
                carpeta = "mascotas";

            }
            else if (folder == Folders.Temporal) 
            {
                carpeta = "temp";
            
            }

            string rootPath = hostEnvironment.WebRootPath;
            string path = Path.Combine(rootPath,"uploads",carpeta ,fileName);
            return path;

        }


    }
}
