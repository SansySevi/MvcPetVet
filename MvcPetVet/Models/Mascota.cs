using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MvcPetVet.Models
{

    [Table("MASCOTAS")]
    public class Mascota
    {
        [Key]
        [Column("IDMASCOTA")]
        public int IdMascota { get; set; }

        [Column("NOMBRE")]
        public string Nombre { get; set; }

        [Column("EDAD")]
        public int Edad { get; set; }

        [Column("PESO")]
        public int Peso { get; set; }

        [Column("RAZA")]
        public string Raza { get; set; }

        [Column("IDUSUARIO")]
        public int IdUsuario { get; set; }
    }
}
