using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MvcPetVet.Models
{

    [Table("V_PRUEBAS")]
    public class Prueba
    {
        [Key]
        [Column("IDPRUEBA")]
        public int IdPrueba { get; set; }

        [Column("IDUSUARIO")]
        public int IdUsuario { get; set; }

        [Column("IDMASCOTA")]
        public int IdMascota { get; set; }

        [Column("NMASCOTA")]
        public string NameMascota { get; set; }

        [Column("NAME_FILE")]
        public string NameFile { get; set; }

        [Column("DESCRIPCION")]
        public string Descripcion { get; set; }

        [Column("FECHA")]
        public DateTime Fecha { get; set; }

    }
}
