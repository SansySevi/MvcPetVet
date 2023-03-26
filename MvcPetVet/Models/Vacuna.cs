using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MvcPetVet.Models
{

    [Table("V_VACUNAS")]
    public class Vacuna
    {
        [Key]
        [Column("IDVACUNA")]
        public int IdVacuna { get; set; }

        [Column("IDUSUARIO")]
        public int IdUsuario { get; set; }

        [Column("IDMASCOTA")]
        public int IdMascota { get; set; }

        [Column("NMASCOTA")]
        public string NameMascota { get; set; }

        [Column("NVACUNA")]
        public string NameVacuna { get; set; }

        [Column("LOTE")]
        public string Lote { get; set; }

        [Column("FECHA")]
        public DateTime Fecha { get; set; }

    }
}
