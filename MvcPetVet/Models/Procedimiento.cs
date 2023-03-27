using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MvcPetVet.Models
{

    [Table("V_PROCEDIMIENTOS")]
    public class Procedimiento
    {
        [Key]
        [Column("IDPROCEDIMEINTO")]
        public int Id { get; set; }

        [Column("IDUSUARIO")]
        public int IdUsuario { get; set; }

        [Column("IDMASCOTA")]
        public int IdMascota { get; set; }

        [Column("NMASCOTA")]
        public string NameMascota { get; set; }

        [Column("TIPO")]
        public string Tipo { get; set; }

        [Column("MEDICAMENTOS_UTILIZADOS")]
        public string Medicamentos { get; set; }

        [Column("OBSERVACIONES")]
        public string Observaciones { get; set; }

        [Column("RECOMENDACIONES")]
        public string Recomendaciones { get; set; }

        [Column("FECHA")]
        public DateTime Fecha { get; set; }

    }
}
