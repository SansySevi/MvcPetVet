using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MvcPetVet.Models
{
    [Table("V_TRATAMIENTOS")]
    public class Tratamiento
    {
        [Key]
        [Column("IDTRATAMIENTO")]
        public int IdTratamiento { get; set; }

        [Column("IDUSUARIO")]
        public int IdUsuario { get; set; }

        [Column("IDMASCOTA")]
        public int IdMascota { get; set; }

        [Column("NMASCOTA")]
        public string NameMascota { get; set; }

        [Column("NOMBREMEDICACION")]
        public string NombreMedicacion { get; set; }

        [Column("DOSIS")]
        public string Dosis { get; set; }

        [Column("DURACION")]
        public string Duracion { get; set; }

        [Column("DESCRIPCION")]
        public string Descripcion { get; set; }

        [Column("FECHA_INICIO")]
        public DateTime FechaInicio { get; set; }

        [Column("FECHA_FIN")]
        public DateTime FechaFin { get; set; }

    }
}
