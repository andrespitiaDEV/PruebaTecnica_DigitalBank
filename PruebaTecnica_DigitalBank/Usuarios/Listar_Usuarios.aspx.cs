using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PruebaTecnica.Entities;
using PruebaTecnica_DigitalBank.ServiceReference;


namespace PruebaTecnica_DigitalBank.Usuarios
{
    public partial class Listar_Usuarios : System.Web.UI.Page
    {
        private readonly IUsuarioService _serviceClient = new UsuarioServiceClient();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarUsuarios();
            }
        }

        private void CargarUsuarios()
        {
            try
            {
                List<Usuario> usuarios = _serviceClient.Consultar().ToList();

                gvUsuarios.DataSource = usuarios;
                gvUsuarios.DataBind();
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error al cargar los usuarios: " + ex.Message;
                lblMensaje.Visible = true;
                lblMensaje.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void gvUsuarios_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int idUsuario = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Modificar")
            {
                Response.Redirect($"Registrar_Usuarios.aspx?id={idUsuario}");
            }
            else if (e.CommandName == "Eliminar")
            {
                try
                {
                    if (_serviceClient.Eliminar(idUsuario))
                    {
                        lblMensaje.Text = $"Usuario con ID {idUsuario} eliminado exitosamente.";
                        lblMensaje.Visible = true;
                        lblMensaje.ForeColor = System.Drawing.Color.Green;

                        CargarUsuarios();
                    }
                    else
                    {
                        lblMensaje.Text = "No se pudo eliminar el usuario.";
                        lblMensaje.Visible = true;
                        lblMensaje.ForeColor = System.Drawing.Color.Red;
                    }
                }
                catch (Exception ex)
                {
                    lblMensaje.Text = "Error al intentar eliminar: " + ex.Message;
                    lblMensaje.Visible = true;
                    lblMensaje.ForeColor = System.Drawing.Color.Red;
                }
            }
        }
    }
}