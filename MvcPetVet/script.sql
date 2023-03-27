/****** Object:  Table [dbo].[TRATAMIENTOS]    Script Date: 27/03/2023 7:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TRATAMIENTOS](
	[IDTRATAMIENTO] [int] NOT NULL,
	[IDUSUARIO] [int] NOT NULL,
	[IDMASCOTA] [int] NOT NULL,
	[NOMBREMEDICACION] [nvarchar](75) NOT NULL,
	[DOSIS] [nvarchar](20) NOT NULL,
	[DURACION] [nvarchar](50) NOT NULL,
	[DESCRIPCION] [nvarchar](100) NOT NULL,
	[FECHA_INICIO] [datetime] NOT NULL,
	[FECHA_FIN] [date] NULL,
 CONSTRAINT [PK__TRATAMIE__0C5A875D8514F6B3] PRIMARY KEY CLUSTERED 
(
	[IDTRATAMIENTO] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MASCOTAS]    Script Date: 27/03/2023 7:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MASCOTAS](
	[IDMASCOTA] [int] NOT NULL,
	[NMASCOTA] [nvarchar](50) NOT NULL,
	[PESO] [int] NULL,
	[RAZA] [nvarchar](50) NULL,
	[IDUSUARIO] [int] NOT NULL,
	[IMAGEN] [nvarchar](max) NULL,
	[TIPO] [nvarchar](15) NOT NULL,
	[FECHA_NACIMIENTO] [date] NULL,
 CONSTRAINT [PK__MASCOTAS__6DF5E8145243124D] PRIMARY KEY CLUSTERED 
(
	[IDMASCOTA] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_TRATAMIENTOS]    Script Date: 27/03/2023 7:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_TRATAMIENTOS]
AS
	SELECT IDTRATAMIENTO, TRATAMIENTOS.IDUSUARIO, TRATAMIENTOS.IDMASCOTA, NMASCOTA, NOMBREMEDICACION, DOSIS, DURACION, DESCRIPCION, FECHA_INICIO , FECHA_FIN
	FROM TRATAMIENTOS
	LEFT JOIN MASCOTAS
	ON TRATAMIENTOS.IDMASCOTA = MASCOTAS.IDMASCOTA
GO
/****** Object:  Table [dbo].[CITAS]    Script Date: 27/03/2023 7:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CITAS](
	[IDCITA] [int] NOT NULL,
	[IDUSUARIO] [int] NOT NULL,
	[IDMASCOTA] [int] NOT NULL,
	[TIPO_CITA] [nvarchar](50) NOT NULL,
	[DIA_CITA] [datetime] NOT NULL,
 CONSTRAINT [PK__CITAS__0ED2547D2E5F8285] PRIMARY KEY CLUSTERED 
(
	[IDCITA] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_CITAS]    Script Date: 27/03/2023 7:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_CITAS]
AS
	SELECT IDCITA, CITAS.IDUSUARIO, CITAS.IDMASCOTA, NMASCOTA, TIPO_CITA, DIA_CITA
	FROM CITAS
	LEFT JOIN MASCOTAS
	ON CITAS.IDMASCOTA = MASCOTAS.IDMASCOTA
GO
/****** Object:  View [dbo].[V_EVENTOS]    Script Date: 27/03/2023 7:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_EVENTOS]
as
	SELECT IDCITA as "ID", NMASCOTA + ' - '+ TIPO_CITA  as "TITLE", DIA_CITA as "START", IDUSUARIO FROM V_CITAS
GO
/****** Object:  Table [dbo].[VACUNAS]    Script Date: 27/03/2023 7:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VACUNAS](
	[IDVACUNA] [int] NULL,
	[IDUSUARIO] [int] NULL,
	[IDMASCOTA] [int] NULL,
	[NVACUNA] [nvarchar](50) NULL,
	[FECHA] [date] NULL,
	[LOTE] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_VACUNAS]    Script Date: 27/03/2023 7:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_VACUNAS]
as
	select IDVACUNA, vacunas.IDUSUARIO, vacunas.IDMASCOTA, NMASCOTA, NVACUNA,LOTE , FECHA, mascotas.IMAGEN
	from vacunas 
	left join mascotas
	on vacunas.idmascota = mascotas.idmascota
GO
/****** Object:  Table [dbo].[PRUEBAS]    Script Date: 27/03/2023 7:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRUEBAS](
	[IDPRUEBA] [int] NOT NULL,
	[IDUSUARIO] [int] NOT NULL,
	[IDMASCOTA] [int] NOT NULL,
	[NAME_FILE] [nvarchar](max) NOT NULL,
	[DESCRIPCION] [nvarchar](150) NOT NULL,
	[FECHA] [date] NOT NULL,
 CONSTRAINT [PK_PRUEBAS] PRIMARY KEY CLUSTERED 
(
	[IDPRUEBA] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_PRUEBAS]    Script Date: 27/03/2023 7:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_PRUEBAS]
AS
	SELECT IDPRUEBA, PRUEBAS.IDUSUARIO, PRUEBAS.IDMASCOTA, NMASCOTA, NAME_FILE, DESCRIPCION, FECHA
	FROM PRUEBAS
	LEFT JOIN MASCOTAS
	ON PRUEBAS.IDMASCOTA = MASCOTAS.IDMASCOTA
GO
/****** Object:  Table [dbo].[PROCEDIMIENTOS]    Script Date: 27/03/2023 7:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PROCEDIMIENTOS](
	[IDPROCEDIMEINTO] [int] NOT NULL,
	[FECHA] [date] NULL,
	[MEDICAMENTOS_UTILIZADOS] [nvarchar](150) NULL,
	[OBSERVACIONES] [nvarchar](max) NULL,
	[RECOMENDACIONES] [nvarchar](max) NULL,
	[IDMASCOTA] [int] NULL,
	[IDUSUARIO] [int] NULL,
	[TIPO] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDPROCEDIMEINTO] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_PROCEDIMIENTOS]    Script Date: 27/03/2023 7:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create VIEW [dbo].[V_PROCEDIMIENTOS]
as
	select IDPROCEDIMEINTO, PROCEDIMIENTOS.IDUSUARIO, PROCEDIMIENTOS.IDMASCOTA, NMASCOTA, PROCEDIMIENTOS.TIPO, FECHA, MEDICAMENTOS_UTILIZADOS, OBSERVACIONES, RECOMENDACIONES
	from PROCEDIMIENTOS 
	left join mascotas
	on PROCEDIMIENTOS.idmascota = mascotas.idmascota
GO
/****** Object:  Table [dbo].[EVENTOS]    Script Date: 27/03/2023 7:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EVENTOS](
	[IDEVENTO] [int] NOT NULL,
	[EVENTO] [nvarchar](150) NULL,
	[INICIOEVENTO] [datetime] NULL,
	[FINEVENTO] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDEVENTO] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FAQS]    Script Date: 27/03/2023 7:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FAQS](
	[IDFAQ] [int] NOT NULL,
	[NOMBRE] [nvarchar](250) NULL,
	[DESCRIPCION] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDFAQ] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SERVICIOS]    Script Date: 27/03/2023 7:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SERVICIOS](
	[IDSERVICIO] [int] NOT NULL,
	[NOMBRE] [nvarchar](50) NULL,
	[DESCRIPCION] [nvarchar](500) NULL,
	[IMAGEN] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDSERVICIO] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[USUARIOS]    Script Date: 27/03/2023 7:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USUARIOS](
	[IDUSUARIO] [int] NOT NULL,
	[APODO] [nvarchar](50) NOT NULL,
	[NOMBRE] [nvarchar](50) NULL,
	[EMAIL] [nvarchar](150) NOT NULL,
	[SALT] [nvarchar](max) NOT NULL,
	[PASS] [nvarchar](50) NOT NULL,
	[PASS_CIFRADA] [varbinary](max) NOT NULL,
	[IMAGEN] [nvarchar](max) NULL,
	[TELEFONO] [nvarchar](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDUSUARIO] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[CITAS] ([IDCITA], [IDUSUARIO], [IDMASCOTA], [TIPO_CITA], [DIA_CITA]) VALUES (1, 1, 1, N'General', CAST(N'2023-03-31T16:30:00.000' AS DateTime))
INSERT [dbo].[CITAS] ([IDCITA], [IDUSUARIO], [IDMASCOTA], [TIPO_CITA], [DIA_CITA]) VALUES (2, 1, 1, N'General', CAST(N'2023-04-07T18:30:00.000' AS DateTime))
INSERT [dbo].[CITAS] ([IDCITA], [IDUSUARIO], [IDMASCOTA], [TIPO_CITA], [DIA_CITA]) VALUES (3, 1, 2, N'General', CAST(N'2023-03-31T16:45:00.000' AS DateTime))
INSERT [dbo].[CITAS] ([IDCITA], [IDUSUARIO], [IDMASCOTA], [TIPO_CITA], [DIA_CITA]) VALUES (4, 1, 1, N'Revisión', CAST(N'2023-04-15T12:30:00.000' AS DateTime))
INSERT [dbo].[CITAS] ([IDCITA], [IDUSUARIO], [IDMASCOTA], [TIPO_CITA], [DIA_CITA]) VALUES (5, 1, 2, N'General', CAST(N'2023-04-15T12:45:00.000' AS DateTime))
GO
INSERT [dbo].[EVENTOS] ([IDEVENTO], [EVENTO], [INICIOEVENTO], [FINEVENTO]) VALUES (1, N'FORO EMPLEO MAÑANAS', CAST(N'2023-01-18T09:00:00.000' AS DateTime), CAST(N'2023-01-18T14:30:00.000' AS DateTime))
INSERT [dbo].[EVENTOS] ([IDEVENTO], [EVENTO], [INICIOEVENTO], [FINEVENTO]) VALUES (2, N'FORO EMPLEO TARDES', CAST(N'2023-01-18T16:00:00.000' AS DateTime), CAST(N'2023-01-18T20:00:00.000' AS DateTime))
GO
INSERT [dbo].[FAQS] ([IDFAQ], [NOMBRE], [DESCRIPCION]) VALUES (1, N'¿Qué hacer si mi perro tiene garrapatas?', N'En primer lugar, cogeremos unas pinzas de extraer, para ver con pelos, y apartaremos el pelo del perro para ver con claridad la garrapata. Con delicadeza, debemos cerrar las pinzas lo más cerca posible de la cabeza de la garrapata. Es importante cogerla de esta parte, que puede sobresalir ligeramente de la piel del perro, de lo contrario puede partirse.
Para extraerla, debemos estirar de forma constante, con firmeza, pero sin ejercer demasiada fuerza, hacia arriba y ligeramente hacia abajo. Así, la garrapata terminará por salir entera. Después es necesario eliminarla, lo mejor es aplastarla o quemarla.
Por último, procederemos a desinfectar la zona con agua jabón y si fuera necesario, con agua oxigenada.
Si no estamos seguros de ser capaces de quitarle las garrapatas a nuestro perro, lo recomendable sería acudir al veterinario.
')
INSERT [dbo].[FAQS] ([IDFAQ], [NOMBRE], [DESCRIPCION]) VALUES (2, N'¿Cómo curar una herida en la almohadilla?', N'Cuando tu perro se haga una herida, lo primero es valorar si es superficial o profunda y si sangra o no.
1.	Es posible que al perro le duela la zona y, aunque tenga un buen carácter, puede intentar morderte mientras le curas, para prevenirlo utiliza un bozal. Es recomendable usar guantes. Si el perro tiene el pelo largo, es mejor recortarle los pelos alrededor de la herida antes de curarla.
2.	Limpia la herida con suero fisiológico, si no tuvieras utiliza agua con un poco de jabón diluido. Utiliza siempre gasas estériles y si no tuvieras un paño muy limpio. La limpieza debe hacerse siempre desde dentro hacia afuera. Revisa si hubiera algún material extraño, como trozos de barro seco, restos de hierba o posibles restos de cristal. Para terminar de limpiarla es conveniente desinfectarla, lo mejor usar agua oxigenada.
        Por último, para una buena cicatrización siempre es mejor dejar la herida al aire. No es conveniente utilizar betadine, si antes no lo hemos diluido con agua.
')
INSERT [dbo].[FAQS] ([IDFAQ], [NOMBRE], [DESCRIPCION]) VALUES (3, N'¿Cómo cuidar una herida con punto de sutura?', N'La limpieza debe repetirse 2 o 3 veces al día. Limpia la herida con suero fisiológico, si no tienes en casa utiliza agua con un poco de jabón diluido. Usa siempre gasa estériles, nunca algodón, porque deja restos de fibra en la herida. Si no tienes gasas, un paño limpio es suficiente. Tras ello, se deben colocar apósitos o un vendaje ligero para evitar que el animal pueda lamerse o rascarse la herida. Por el mismo motivo, es recomendable ponerle una campana o collar isabelino que impida que el perro se toque la herida.')
INSERT [dbo].[FAQS] ([IDFAQ], [NOMBRE], [DESCRIPCION]) VALUES (4, N'¿Cómo limpiar los ojos de mi perro si tiene legañas?', N'Los profesionales indican que, si las legañas son de un color blanco o transparente, pueden ser indicativo de que el perro esté sufriendo una reacción alérgica.
El suero fisiológico es perfecto para limpiar los ojos de tu mascota, ya que su composición es muy neutra y, por tanto, es apta para esta zona tan delicada. Sin embargo, el agua de manzanilla es un remedio que mucha gente piensa que es efectivo para limpiar los ojos de un perro, pero está demostrado que no es así, porque puede provocar más irritaciones.
')
GO
INSERT [dbo].[MASCOTAS] ([IDMASCOTA], [NMASCOTA], [PESO], [RAZA], [IDUSUARIO], [IMAGEN], [TIPO], [FECHA_NACIMIENTO]) VALUES (1, N'Slash', 16, N'Mestizo', 1, N'IMG-20191103-WA0000.jpg', N'Perro', CAST(N'2014-05-21' AS Date))
INSERT [dbo].[MASCOTAS] ([IDMASCOTA], [NMASCOTA], [PESO], [RAZA], [IDUSUARIO], [IMAGEN], [TIPO], [FECHA_NACIMIENTO]) VALUES (2, N'Lola', 11, N'Mestizo', 1, N'default_pet.webp', N'perro', CAST(N'2006-11-07' AS Date))
INSERT [dbo].[MASCOTAS] ([IDMASCOTA], [NMASCOTA], [PESO], [RAZA], [IDUSUARIO], [IMAGEN], [TIPO], [FECHA_NACIMIENTO]) VALUES (3, N'Bam', 18, N'Doberman', 2, N'default_pet.webp', N'perro', CAST(N'2020-05-17' AS Date))
INSERT [dbo].[MASCOTAS] ([IDMASCOTA], [NMASCOTA], [PESO], [RAZA], [IDUSUARIO], [IMAGEN], [TIPO], [FECHA_NACIMIENTO]) VALUES (4, N'Song', 16, N'Galgo', 2, N'default_pet.webp', N'perro', CAST(N'2021-10-25' AS Date))
INSERT [dbo].[MASCOTAS] ([IDMASCOTA], [NMASCOTA], [PESO], [RAZA], [IDUSUARIO], [IMAGEN], [TIPO], [FECHA_NACIMIENTO]) VALUES (5, N'Paeng', 15, N'Galgo', 2, N'default_pet.webp', N'perro', CAST(N'2021-10-25' AS Date))
GO
INSERT [dbo].[PROCEDIMIENTOS] ([IDPROCEDIMEINTO], [FECHA], [MEDICAMENTOS_UTILIZADOS], [OBSERVACIONES], [RECOMENDACIONES], [IDMASCOTA], [IDUSUARIO], [TIPO]) VALUES (1, CAST(N'2009-03-15' AS Date), N'Anestesia general', N'El procedimiento se realizó sin complicaciones. Se aplicó un collar isabelino para evitar que la mascota se lama la herida. Se indicó al dueño que evite darle baños o sumergir a la mascota en agua durante al menos una semana. Se programó una revisión de seguimiento para retirar los puntos de sutura en 10 días.', N'Mantener a la mascota en reposo durante al menos 24 horas. Proporcionar un lugar cálido y cómodo para descansar. Controlar la ingesta de alimentos y agua. Administrar los medicamentos prescritos por el veterinario según las instrucciones. Monitorear la herida para detectar signos de infección o inflamación.', 2, 1, N'Esterilización')
INSERT [dbo].[PROCEDIMIENTOS] ([IDPROCEDIMEINTO], [FECHA], [MEDICAMENTOS_UTILIZADOS], [OBSERVACIONES], [RECOMENDACIONES], [IDMASCOTA], [IDUSUARIO], [TIPO]) VALUES (2, CAST(N'2021-05-10' AS Date), N'Anestesia general y analgésicos', N'El procedimiento se realizó sin complicaciones. Se indicó al dueño que evite darle comida dura o juguetes para masticar durante al menos una semana para permitir que la herida sane adecuadamente. Se programó una revisión de seguimiento para verificar que la herida esté sanando correctamente.', N'', 1, 1, N'Extracción dental')
INSERT [dbo].[PROCEDIMIENTOS] ([IDPROCEDIMEINTO], [FECHA], [MEDICAMENTOS_UTILIZADOS], [OBSERVACIONES], [RECOMENDACIONES], [IDMASCOTA], [IDUSUARIO], [TIPO]) VALUES (3, CAST(N'2021-08-20' AS Date), N'Antiparasitario tópico', N'Se aplicó el tratamiento tópico contra pulgas y garrapatas. Se indicó al dueño que mantenga a la mascota alejada del agua durante al menos 24 horas para permitir que el tratamiento se absorba completamente en la piel. Se recordó al dueño que debe aplicar el tratamiento según las indicaciones del veterinario', N'', 2, 1, N'Tratamiento contra pulgas y garrapatas')
INSERT [dbo].[PROCEDIMIENTOS] ([IDPROCEDIMEINTO], [FECHA], [MEDICAMENTOS_UTILIZADOS], [OBSERVACIONES], [RECOMENDACIONES], [IDMASCOTA], [IDUSUARIO], [TIPO]) VALUES (4, CAST(N'2021-11-05' AS Date), N'Anestesia general', N'Se tomó una muestra para realizar una biopsia. Se indicó al dueño que mantenga a la mascota en reposo durante al menos 24 horas después del procedimiento. Se programó una revisión de seguimiento para entregar los resultados de la biopsia y discutir los siguientes pasos.', N'', 2, 1, N'Biopsia')
INSERT [dbo].[PROCEDIMIENTOS] ([IDPROCEDIMEINTO], [FECHA], [MEDICAMENTOS_UTILIZADOS], [OBSERVACIONES], [RECOMENDACIONES], [IDMASCOTA], [IDUSUARIO], [TIPO]) VALUES (5, CAST(N'2022-01-05' AS Date), N'Ninguno', N'Se realizó una radiografía del abdomen para evaluar posibles problemas gastrointestinales. Se indicó al dueño que mantenga a la mascota en reposo después del procedimiento para permitir que se recupere de la sedación. Se programó una revisión de seguimiento para entregar los resultados de la radiografía y discutir los próximos pasos.', N'', 1, 1, N'Radiografía')
GO
INSERT [dbo].[PRUEBAS] ([IDPRUEBA], [IDUSUARIO], [IDMASCOTA], [NAME_FILE], [DESCRIPCION], [FECHA]) VALUES (1, 1, 1, N'analitica_20230127.pdf', N'analitica orina', CAST(N'2023-01-27' AS Date))
INSERT [dbo].[PRUEBAS] ([IDPRUEBA], [IDUSUARIO], [IDMASCOTA], [NAME_FILE], [DESCRIPCION], [FECHA]) VALUES (2, 1, 1, N'RX_SLASH_1.jpg', N'Rayos Vejiga', CAST(N'2023-03-11' AS Date))
INSERT [dbo].[PRUEBAS] ([IDPRUEBA], [IDUSUARIO], [IDMASCOTA], [NAME_FILE], [DESCRIPCION], [FECHA]) VALUES (3, 1, 1, N'analitica_20230203.pdf', N'analitica sangre', CAST(N'2023-02-03' AS Date))
INSERT [dbo].[PRUEBAS] ([IDPRUEBA], [IDUSUARIO], [IDMASCOTA], [NAME_FILE], [DESCRIPCION], [FECHA]) VALUES (4, 1, 1, N'RX_SLASH_2.jpg', N'Rayos Vejiga', CAST(N'2023-03-11' AS Date))
INSERT [dbo].[PRUEBAS] ([IDPRUEBA], [IDUSUARIO], [IDMASCOTA], [NAME_FILE], [DESCRIPCION], [FECHA]) VALUES (5, 1, 2, N'analitica_20210201.pdf', N'analitica sangre', CAST(N'2021-02-01' AS Date))
INSERT [dbo].[PRUEBAS] ([IDPRUEBA], [IDUSUARIO], [IDMASCOTA], [NAME_FILE], [DESCRIPCION], [FECHA]) VALUES (6, 1, 2, N'EQ_LOLA_1.jpg', N'Eco Corazón', CAST(N'2011-07-05' AS Date))
INSERT [dbo].[PRUEBAS] ([IDPRUEBA], [IDUSUARIO], [IDMASCOTA], [NAME_FILE], [DESCRIPCION], [FECHA]) VALUES (7, 1, 2, N'EQ_LOLA_2.jpg', N'Eco Corazón', CAST(N'2011-07-05' AS Date))
GO
INSERT [dbo].[SERVICIOS] ([IDSERVICIO], [NOMBRE], [DESCRIPCION], [IMAGEN]) VALUES (1, N'Medicina preventiva', N'Vacunas, desparasitaciones internas y externas, revisiones periódicas (revisiones anuales, revisiones geriátricas, revisión de cachorros...)', N'service1.jpg')
INSERT [dbo].[SERVICIOS] ([IDSERVICIO], [NOMBRE], [DESCRIPCION], [IMAGEN]) VALUES (2, N'Identificación animal', N'Implantación de microchip en perros, gatos y hurones.
El microchip es un dispositivo que se implanta bajo la piel de su mascota, a la altura del cuello, donde se incluyen los datos tanto del animal como de su propietario. Es la forma más rápida y segura de identificar a su animal de compañía.', N'service2.jpg')
INSERT [dbo].[SERVICIOS] ([IDSERVICIO], [NOMBRE], [DESCRIPCION], [IMAGEN]) VALUES (3, N'Diagnóstico por imagen', N'Radiología simple y con contraste. Ecografía abdominal previa cita.', N'service3.jpg')
INSERT [dbo].[SERVICIOS] ([IDSERVICIO], [NOMBRE], [DESCRIPCION], [IMAGEN]) VALUES (4, N'Laboratorio', N'Laboratorio propio de análisis clínicos para analíticas sanguíneas. 
Laboratorio externo para citologías, biopsias y analisis de orina y heces. 
Test canino de leishmaniosis, parvovirus y coronavirus y felinos de leucemia, inmunodeficiencia y panleucopenia, con resultados inmediatos.', N'service4.jpg')
INSERT [dbo].[SERVICIOS] ([IDSERVICIO], [NOMBRE], [DESCRIPCION], [IMAGEN]) VALUES (5, N'Cirugía general', N'Disponemos de quirófano totalmente equipado donde realizamos cirugía general de tejidos blandos.', N'service5.jpg')
INSERT [dbo].[SERVICIOS] ([IDSERVICIO], [NOMBRE], [DESCRIPCION], [IMAGEN]) VALUES (6, N'Peluquería canina y felina', N'Disponemos de peluquería previa cita. Realizamos corte de todas las razas y también mestizos.
Higiene incluída en el servicio: Limpieza de oidos, corte de uñas, glándulas perianales.
Además baños terapéuticos, baños antiparasitarios, uñas de silicona para gatos, arreglo de orejas y cara...', N'service6.jpg')
INSERT [dbo].[SERVICIOS] ([IDSERVICIO], [NOMBRE], [DESCRIPCION], [IMAGEN]) VALUES (7, N'Salud dental', N'Pregúntanos sobre todo lo que puedes hacer en casa para mantener la salud bucal de tu mascota. En relación al bienestar bucal lo mejor es la prevención.
En caso necesario, realizamos limpiezas de boca y extracciones dentales.
Las limpiezas bucales requieren anestesia general por lo que antes de realizarla haremos una revisión completa del paciente.', N'service7.jpg')
INSERT [dbo].[SERVICIOS] ([IDSERVICIO], [NOMBRE], [DESCRIPCION], [IMAGEN]) VALUES (8, N'Reproducción', N'Asesoramiento en relación a problemas de reproducción. Realizamos citologías, inducción de celo e inseminación artificial en perras.
Control de gestación en perras y gatas: Pregúntanos sobre los cuidados antes, durante y después de la gestación. Hacemos diagnóstico de gestación mediante ecografía, y en caso de que sea necesario, realizamos cesáreas de urgencia y programadas.
Control de patalogías de aparato reproductor.', N'service8.jpg')
INSERT [dbo].[SERVICIOS] ([IDSERVICIO], [NOMBRE], [DESCRIPCION], [IMAGEN]) VALUES (9, N'Otros servicios', N'Además de todos los servicios comentados anteriormente, contamos con:
-Piensos dietéticos y complementos nutricionales
-Antiparasitarios externos
-Visitas a domicilio con cita previa.', N'service9.jpg')
GO
INSERT [dbo].[TRATAMIENTOS] ([IDTRATAMIENTO], [IDUSUARIO], [IDMASCOTA], [NOMBREMEDICACION], [DOSIS], [DURACION], [DESCRIPCION], [FECHA_INICIO], [FECHA_FIN]) VALUES (1, 1, 1, N'Minipres', N'1/2 - 2 al día', N'Finalizacion de medicación', N'Relajante muscular uretral', CAST(N'2023-03-23T00:03:50.097' AS DateTime), CAST(N'0001-01-01' AS Date))
INSERT [dbo].[TRATAMIENTOS] ([IDTRATAMIENTO], [IDUSUARIO], [IDMASCOTA], [NOMBREMEDICACION], [DOSIS], [DURACION], [DESCRIPCION], [FECHA_INICIO], [FECHA_FIN]) VALUES (2, 1, 1, N'Inflacam', N'1/2 - 2 al día', N'1 semana', N'Antiinflamatorio', CAST(N'2023-03-23T00:03:50.097' AS DateTime), CAST(N'2023-03-30' AS Date))
INSERT [dbo].[TRATAMIENTOS] ([IDTRATAMIENTO], [IDUSUARIO], [IDMASCOTA], [NOMBREMEDICACION], [DOSIS], [DURACION], [DESCRIPCION], [FECHA_INICIO], [FECHA_FIN]) VALUES (3, 1, 1, N'Hepato Pharma', N'1 - 2 al día', N'Finalizacion de medicación', N'Hepático', CAST(N'2023-03-23T00:03:50.097' AS DateTime), CAST(N'0001-01-01' AS Date))
INSERT [dbo].[TRATAMIENTOS] ([IDTRATAMIENTO], [IDUSUARIO], [IDMASCOTA], [NOMBREMEDICACION], [DOSIS], [DURACION], [DESCRIPCION], [FECHA_INICIO], [FECHA_FIN]) VALUES (4, 1, 2, N'Terracortril', N'1 al día', N'2 semanas', N'Pomada antibiotica ótico-oftálmica', CAST(N'2023-03-23T00:03:50.097' AS DateTime), CAST(N'2023-04-06' AS Date))
INSERT [dbo].[TRATAMIENTOS] ([IDTRATAMIENTO], [IDUSUARIO], [IDMASCOTA], [NOMBREMEDICACION], [DOSIS], [DURACION], [DESCRIPCION], [FECHA_INICIO], [FECHA_FIN]) VALUES (5, 1, 2, N'Tobrex', N'1 al día', N'2 semanas', N'Colirio en solución', CAST(N'2023-03-23T00:03:50.097' AS DateTime), CAST(N'2023-04-06' AS Date))
GO
INSERT [dbo].[USUARIOS] ([IDUSUARIO], [APODO], [NOMBRE], [EMAIL], [SALT], [PASS], [PASS_CIFRADA], [IMAGEN], [TELEFONO]) VALUES (1, N'Sansy', N'Sandra', N'sglez@gmail.com', N'd_È«n¢V=¼ºÙõnÔBóm° U]w£/¦Âæ', N'12345', 0xFDDFCA9A4A0B32E4E4F206CC415A98CD2F14E183513D7B5674E3C855D9B03C2B305D388F6E35AD2073E59217DA2AA46BA342CD9EABCE9364775D197DF6252C83, N'home.jpg', N'663684856')
INSERT [dbo].[USUARIOS] ([IDUSUARIO], [APODO], [NOMBRE], [EMAIL], [SALT], [PASS], [PASS_CIFRADA], [IMAGEN], [TELEFONO]) VALUES (2, N'JKookie', N'Jung-Kook', N'jk.bts@gmail.com', N'}±TkóQ¿BXm	<^Ç<õrÅ×öuÁæòD¿üqÊni9Á÷;', N'12345', 0x5442F38507DDBA8412042F3C943E66879E6BE2C864EDD8B5DD60FE2A3F04EA93251BA932456AF16832985AC7A9F9EC104ED51BA550EFF882363D6C775885D098, N'Piskel-0002368_600.png', N'663684892')
INSERT [dbo].[USUARIOS] ([IDUSUARIO], [APODO], [NOMBRE], [EMAIL], [SALT], [PASS], [PASS_CIFRADA], [IMAGEN], [TELEFONO]) VALUES (3, N'Bummy', N'', N'bummer@gmail.com', N'|ú´£050ïûÏÀéCéïHôüC$ajÓkvµ
+,MóÜ¸ê°§ØÝ', N'12345', 0x8C9DB5C359501326FB2464A5A7322FD2264C74F149C9D6630779A2F9B7A05997EFC8E1BDBE5B1CA55F2C4FD784C8F0AA5ECCA417E6D75841A9E7C57ABDE676C0, N'default_img.webp', N'')
INSERT [dbo].[USUARIOS] ([IDUSUARIO], [APODO], [NOMBRE], [EMAIL], [SALT], [PASS], [PASS_CIFRADA], [IMAGEN], [TELEFONO]) VALUES (4, N'Tae', N'', N'v.bts@gmail.com', N'J/l:lï, º/I.¶®Ì }¬úóÑ16¿ñøJ ¦7íjõ)z@â7orB', N'12345', 0xA8A0623A2AA7CDF6302BAD8A05EC1607EB7DBDA7208472476C04BE46519515656DC32CB44A2C1BA597A00B7F20FF59C434EA0B1218BD1B9AF2266AD4E236FC45, N'default_img.webp', N'')
INSERT [dbo].[USUARIOS] ([IDUSUARIO], [APODO], [NOMBRE], [EMAIL], [SALT], [PASS], [PASS_CIFRADA], [IMAGEN], [TELEFONO]) VALUES (5, N'Jiminih', N'', N'jimin.bts@gmail.com', N'q?8Òú«î
/ÃQf°ú	Æ^EZ÷{<ôª&Þª5*?&!±aÕ¢â¦?x^', N'12345', 0xA8B09E435FF210FC98CB5DE183D2897C9B17BEEFCC6AE452E2C0C2176330D1183200603912236C91BAF7B8A79534E4D426B13FD59A360547CEAFC12D1264722E, N'default_img.webp', N'')
INSERT [dbo].[USUARIOS] ([IDUSUARIO], [APODO], [NOMBRE], [EMAIL], [SALT], [PASS], [PASS_CIFRADA], [IMAGEN], [TELEFONO]) VALUES (6, N'Nanjoon', N'', N'rm.bts@gmail.com', N'l¬if«wÜC¼â)ã²	d¯ú½b¦N´É­öÄÙ´ubá¦ö&', N'12345', 0xEC286B77D36CF1EF61E9AB67E75D69955891DBCA9A73CE36A6CCA578D8F767A1A7935D8E413A912673B0DF29C8583FB5C3A01DE439C0FF7374281A96C00995DD, N'default_img.webp', N'')
INSERT [dbo].[USUARIOS] ([IDUSUARIO], [APODO], [NOMBRE], [EMAIL], [SALT], [PASS], [PASS_CIFRADA], [IMAGEN], [TELEFONO]) VALUES (7, N'JHope', N'', N'jh.bts@gmail.co', N'¥Cw5ÁhwÖ¿;&ÆncI1B(¾e·³gGpü¹¾â=&Ê WHò2á¤', N'12345', 0x3E7ECD4559F6AFE154585820187C7550480CCF77F09C83866FC22BBA7AE8487FB692B171B5C949E46FAD978BB14918604C21616745C38D2775ED1776BC847B39, N'default_img.webp', N'')
INSERT [dbo].[USUARIOS] ([IDUSUARIO], [APODO], [NOMBRE], [EMAIL], [SALT], [PASS], [PASS_CIFRADA], [IMAGEN], [TELEFONO]) VALUES (8, N'Sugar', N'', N'suga.bts@gmail.com', N'Lµüplbzßñ³úp''f©¶X66ë@FA8dø÷-Æd	ó\£ÂÚöK}àe', N'12345', 0xA950AC8F5B1ED56D81F3C3E5A59DDFFD237401ACF955DB3C2DFBE2C6BE611454AA0375D4325CD404A4ED921DDA31E658171DEB3404F7D1DDE4FC23C6C734BF1D, N'default_img.webp', N'')
INSERT [dbo].[USUARIOS] ([IDUSUARIO], [APODO], [NOMBRE], [EMAIL], [SALT], [PASS], [PASS_CIFRADA], [IMAGEN], [TELEFONO]) VALUES (9, N'Jin', N'', N'jin.bts@gmail.com', N'¤¡ú¢ÑC''+´Ò0ÍWõá:ÏÌ=yûX}<éÒeÔÄ;YÇÀûØÞ"ì :)', N'12345', 0xDDEBB1A9C12D14AB406F7D4BF639D1B4863492DE7E6CD0D3E55AF824B8F74B15961017A0DE834284BCA51B452E27235365D64E63B2C34AE1239AA2485ECE08B8, N'default_img.webp', N'')
GO
INSERT [dbo].[VACUNAS] ([IDVACUNA], [IDUSUARIO], [IDMASCOTA], [NVACUNA], [FECHA], [LOTE]) VALUES (1, 1, 1, N'Canigen L Virbac', CAST(N'2014-07-02' AS Date), N'80816703')
INSERT [dbo].[VACUNAS] ([IDVACUNA], [IDUSUARIO], [IDMASCOTA], [NVACUNA], [FECHA], [LOTE]) VALUES (2, 1, 1, N'Canigen MHa2P Virbac', CAST(N'2014-07-02' AS Date), N'80817003')
INSERT [dbo].[VACUNAS] ([IDVACUNA], [IDUSUARIO], [IDMASCOTA], [NVACUNA], [FECHA], [LOTE]) VALUES (3, 1, 1, N'Eurican R Merial', CAST(N'2014-06-10' AS Date), N'L403036')
INSERT [dbo].[VACUNAS] ([IDVACUNA], [IDUSUARIO], [IDMASCOTA], [NVACUNA], [FECHA], [LOTE]) VALUES (4, 1, 1, N'Raddomun Zoetis', CAST(N'2015-06-18' AS Date), N'100811')
INSERT [dbo].[VACUNAS] ([IDVACUNA], [IDUSUARIO], [IDMASCOTA], [NVACUNA], [FECHA], [LOTE]) VALUES (5, 1, 1, N'Rabigen L Virbac Raddomun', CAST(N'2016-06-03' AS Date), N'5TAW')
INSERT [dbo].[VACUNAS] ([IDVACUNA], [IDUSUARIO], [IDMASCOTA], [NVACUNA], [FECHA], [LOTE]) VALUES (6, 1, 1, N'Eurican R Merial', CAST(N'2017-06-17' AS Date), N'L441564')
INSERT [dbo].[VACUNAS] ([IDVACUNA], [IDUSUARIO], [IDMASCOTA], [NVACUNA], [FECHA], [LOTE]) VALUES (7, 1, 1, N'Eurican R Merial', CAST(N'2018-06-30' AS Date), N'L487613')
INSERT [dbo].[VACUNAS] ([IDVACUNA], [IDUSUARIO], [IDMASCOTA], [NVACUNA], [FECHA], [LOTE]) VALUES (8, 1, 1, N'Rabigen L Virbac Raddomun', CAST(N'2019-07-20' AS Date), N'6TL2')
INSERT [dbo].[VACUNAS] ([IDVACUNA], [IDUSUARIO], [IDMASCOTA], [NVACUNA], [FECHA], [LOTE]) VALUES (9, 1, 1, N'Rabigen L Virbac Raddomun', CAST(N'2020-07-23' AS Date), N'7PS4')
INSERT [dbo].[VACUNAS] ([IDVACUNA], [IDUSUARIO], [IDMASCOTA], [NVACUNA], [FECHA], [LOTE]) VALUES (10, 1, 1, N'Versiguard RabialRabies Zoetis', CAST(N'2021-08-21' AS Date), N'426027A02')
INSERT [dbo].[VACUNAS] ([IDVACUNA], [IDUSUARIO], [IDMASCOTA], [NVACUNA], [FECHA], [LOTE]) VALUES (11, 1, 1, N'Rabisyva VP-13 Syva', CAST(N'2022-12-30' AS Date), N'22001000-O')
INSERT [dbo].[VACUNAS] ([IDVACUNA], [IDUSUARIO], [IDMASCOTA], [NVACUNA], [FECHA], [LOTE]) VALUES (12, 1, 2, N'Duramune Dappi + LC', CAST(N'2008-02-16' AS Date), N'351AY7041')
INSERT [dbo].[VACUNAS] ([IDVACUNA], [IDUSUARIO], [IDMASCOTA], [NVACUNA], [FECHA], [LOTE]) VALUES (13, 1, 2, N'Duramune Dappi + LC', CAST(N'2008-02-16' AS Date), N'351AY7022')
INSERT [dbo].[VACUNAS] ([IDVACUNA], [IDUSUARIO], [IDMASCOTA], [NVACUNA], [FECHA], [LOTE]) VALUES (14, 1, 2, N'Duramune Dappi + LC', CAST(N'2008-03-08' AS Date), N'351AY7032')
INSERT [dbo].[VACUNAS] ([IDVACUNA], [IDUSUARIO], [IDMASCOTA], [NVACUNA], [FECHA], [LOTE]) VALUES (15, 1, 2, N'Duramune Dappi + LC', CAST(N'2008-03-08' AS Date), N'351AY7045')
INSERT [dbo].[VACUNAS] ([IDVACUNA], [IDUSUARIO], [IDMASCOTA], [NVACUNA], [FECHA], [LOTE]) VALUES (16, 1, 2, N'Rabigen L Virbac', CAST(N'2008-06-16' AS Date), N'23PQ')
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__USUARIOS__161CF72408FE972F]    Script Date: 27/03/2023 7:47:51 ******/
ALTER TABLE [dbo].[USUARIOS] ADD UNIQUE NONCLUSTERED 
(
	[EMAIL] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[USUARIOS] ADD  DEFAULT ('default_image.jpg') FOR [IMAGEN]
GO
ALTER TABLE [dbo].[CITAS]  WITH CHECK ADD  CONSTRAINT [FK_CITAS_MASCOTAS] FOREIGN KEY([IDMASCOTA])
REFERENCES [dbo].[MASCOTAS] ([IDMASCOTA])
GO
ALTER TABLE [dbo].[CITAS] CHECK CONSTRAINT [FK_CITAS_MASCOTAS]
GO
ALTER TABLE [dbo].[CITAS]  WITH CHECK ADD  CONSTRAINT [FK_CITAS_USUARIOS] FOREIGN KEY([IDUSUARIO])
REFERENCES [dbo].[USUARIOSTIMER] ([IDUSUARIO])
GO
ALTER TABLE [dbo].[CITAS] CHECK CONSTRAINT [FK_CITAS_USUARIOS]
GO
ALTER TABLE [dbo].[TRATAMIENTOS]  WITH CHECK ADD  CONSTRAINT [FK_TRATAMIENTOS_MASCOTAS] FOREIGN KEY([IDMASCOTA])
REFERENCES [dbo].[MASCOTAS] ([IDMASCOTA])
GO
ALTER TABLE [dbo].[TRATAMIENTOS] CHECK CONSTRAINT [FK_TRATAMIENTOS_MASCOTAS]
GO
ALTER TABLE [dbo].[TRATAMIENTOS]  WITH CHECK ADD  CONSTRAINT [FK_TRATAMIENTOS_USUARIOS] FOREIGN KEY([IDUSUARIO])
REFERENCES [dbo].[USUARIOSTIMER] ([IDUSUARIO])
GO
ALTER TABLE [dbo].[TRATAMIENTOS] CHECK CONSTRAINT [FK_TRATAMIENTOS_USUARIOS]
GO
/****** Object:  StoredProcedure [dbo].[SP_PROCEDIMIENTOS_PAGINAR]    Script Date: 27/03/2023 7:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PROCEDIMIENTOS_PAGINAR]
(@POSICION INT, @IDUSUARIO INT)
AS
    SELECT POSICION, IDPROCEDIMEINTO, IDUSUARIO, IDMASCOTA, NMASCOTA, TIPO, FECHA, MEDICAMENTOS_UTILIZADOS, OBSERVACIONES, RECOMENDACIONES FROM
        (SELECT CAST(
            ROW_NUMBER() OVER(ORDER BY FECHA DESC) AS INT) AS POSICION,
            IDPROCEDIMEINTO, IDUSUARIO, IDMASCOTA, NMASCOTA, TIPO, FECHA, MEDICAMENTOS_UTILIZADOS, OBSERVACIONES, RECOMENDACIONES
        FROM V_PROCEDIMIENTOS
        WHERE IDUSUARIO = @IDUSUARIO) AS QUERY
    WHERE QUERY.POSICION >= @POSICION AND QUERY.POSICION < (@POSICION + 3)
GO
/****** Object:  StoredProcedure [dbo].[SP_VACUNAS_PAGINAR]    Script Date: 27/03/2023 7:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_VACUNAS_PAGINAR]
(@POSICION INT, @IDUSUARIO INT)
AS
    SELECT POSICION, IDVACUNA, IDUSUARIO, IDMASCOTA, NMASCOTA, NVACUNA,LOTE , FECHA, IMAGEN FROM
        (SELECT CAST(
            ROW_NUMBER() OVER(ORDER BY FECHA DESC) AS INT) AS POSICION,
            IDVACUNA, IDUSUARIO, IDMASCOTA, NMASCOTA, NVACUNA,LOTE , FECHA, IMAGEN
        FROM V_VACUNAS
        WHERE IDUSUARIO = @IDUSUARIO) AS QUERY
    WHERE QUERY.POSICION >= @POSICION AND QUERY.POSICION < (@POSICION + 5)
GO
