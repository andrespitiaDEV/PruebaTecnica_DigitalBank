using PruebaTecnica.Entities;
using PruebaTecnica_DigitalBank.ServiceReference;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;

namespace PruebaTecnica_DigitalBank.Usuarios
{
    public partial class Registrar_Usuarios : Page
    {
        private readonly UsuarioServiceClient _serviceClient = new UsuarioServiceClient();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!string.IsNullOrEmpty(Request.QueryString["id"]))
                {
                    CargarDatosParaModificar();
                }
            }
        }

        private void CargarDatosParaModificar()
        {
            try
            {
                int idUsuario = Convert.ToInt32(Request.QueryString["id"]);

                List<Usuario> todosLosUsuarios = _serviceClient.Consultar().ToList();
                Usuario usuario = todosLosUsuarios.Find(u => u.IdUsuario == idUsuario);

                if (usuario != null)
                {
                    hfIdUsuario.Value = usuario.IdUsuario.ToString();
                    lblTitulo.Text = $"<h2>Modificar Usuario: {usuario.Nombre}</h2>";
                    txtNombre.Text = usuario.Nombre;
                    txtFechaNacimiento.Text = usuario.FechaNacimiento.ToString("yyyy-MM-dd");
                    ddlSexo.SelectedValue = usuario.Sexo.ToString();

                    btnGuardar.Text = "Actualizar";
                }
                else
                {
                    lblMensaje.Text = "Error: Usuario no encontrado.";
                    lblMensaje.Visible = true;
                    lblMensaje.ForeColor = System.Drawing.Color.Red;
                }
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error al cargar datos: " + ex.Message;
                lblMensaje.Visible = true;
                lblMensaje.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            Usuario nuevoUsuario = new Usuario
            {
                Nombre = txtNombre.Text,
                FechaNacimiento = Convert.ToDateTime(txtFechaNacimiento.Text),
                Sexo = ddlSexo.SelectedValue[0]
            };

            bool exito;
            int idParaGuardar = Convert.ToInt32(hfIdUsuario.Value);

            if (idParaGuardar > 0)
            {
                nuevoUsuario.IdUsuario = idParaGuardar;
                exito = _serviceClient.Modificar(nuevoUsuario);
                lblMensaje.Text = exito ? "Usuario modificado correctamente." : "Error al modificar el usuario.";
            }
            else
            {
                exito = _serviceClient.Agregar(nuevoUsuario);
                lblMensaje.Text = exito ? "Usuario registrado correctamente." : "Error al registrar el usuario.";

                if (exito)
                {
                    LimpiarControles();
                }
            }

            lblMensaje.Visible = true;
            lblMensaje.ForeColor = exito ? System.Drawing.Color.Green : System.Drawing.Color.Red;
        }

        private void LimpiarControles()
        {
            txtNombre.Text = string.Empty;
            txtFechaNacimiento.Text = string.Empty;
            ddlSexo.SelectedIndex = 0;
            hfIdUsuario.Value = "0";
            lblTitulo.Text = "<h2>Registrar Nuevo Usuario</h2>";
            btnGuardar.Text = "Guardar";
        }
    }
}