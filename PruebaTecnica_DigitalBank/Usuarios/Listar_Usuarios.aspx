<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Listar_Usuarios.aspx.cs"
    Inherits="PruebaTecnica_DigitalBank.Usuarios.Listar_Usuarios" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Consulta y Listado de Usuarios</title>
    <style>
        .navbar {
            background-color: #333; 
            overflow: hidden;
            padding: 10px 0;
            margin-bottom: 20px; 
        }

            .navbar a {
                float: left;
                color: #f2f2f2;
                text-align: center;
                padding: 14px 16px;
                text-decoration: none;
                font-size: 17px;
            }

                .navbar a:hover {
                    background-color: #ddd;
                    color: black;
                }

            .navbar .active {
                background-color: #04AA6D;
                color: white;
            }
        .gridview {
            width: 100%;
            border-collapse: collapse;
            font-family: Arial, sans-serif;
        }

            .gridview th, .gridview td {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: left;
            }

            .gridview th {
                background-color: #f2f2f2;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <div class="navbar">

            <a href="Registrar_Usuarios.aspx">Registrar Usuarios</a>

            <a href="Listar_Usuarios.aspx" class="active">Listar / Consultar Usuarios</a>

        </div>
        <div style="width: 80%; margin: 50px auto; padding: 20px;">

            <h2>Listado de Usuarios Registrados</h2>
            <hr />

            <asp:Label ID="lblMensaje" runat="server" Text="" ForeColor="Green" Visible="false" Style="margin-bottom: 15px; display: block;"></asp:Label>

            <asp:GridView ID="gvUsuarios" runat="server"
                AutoGenerateColumns="False"
                CssClass="gridview"
                DataKeyNames="IdUsuario"
                OnRowCommand="gvUsuarios_RowCommand"
                EmptyDataText="No hay usuarios registrados en el sistema.">

                <Columns>
                    <asp:BoundField DataField="IdUsuario" HeaderText="ID" Visible="False" />

                    <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                    <asp:BoundField DataField="FechaNacimiento" HeaderText="F. Nacimiento" DataFormatString="{0:yyyy-MM-dd}" />
                    <asp:BoundField DataField="Sexo" HeaderText="Sexo" />

                    <asp:TemplateField HeaderText="Acciones">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnModificar" runat="server" Text="Modificar"
                                CommandName="Modificar" CommandArgument='<%# Eval("IdUsuario") %>' />

                            &nbsp;|&nbsp;
                            
                            <asp:LinkButton ID="btnEliminar" runat="server" Text="Eliminar" ForeColor="Red"
                                CommandName="Eliminar" CommandArgument='<%# Eval("IdUsuario") %>'
                                OnClientClick="return confirm('¿Está seguro de que desea eliminar este usuario? Esta acción es irreversible.');" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
