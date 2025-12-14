<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registrar_Usuarios.aspx.cs" 
    Inherits="PruebaTecnica_DigitalBank.Usuarios.Registrar_Usuarios" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Registro y Modificación de Usuarios</title>
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
        .form-container {
            width: 50%;
            margin: 50px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .form-row {
            margin-bottom: 15px;
        }
        .form-row label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .form-row input[type="text"], .form-row select {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .btn-guardar {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        
        <div class="navbar">
            <a href="Registrar_Usuarios.aspx" class="active">Registrar Usuarios</a>
            <a href="Listar_Usuarios.aspx">Listar / Consultar Usuarios</a>
        </div>
        
        <div class="form-container">
            
            <asp:Label ID="lblTitulo" runat="server" Text="<h2>Registrar Nuevo Usuario</h2>" />
            <hr />

            <asp:HiddenField ID="hfIdUsuario" runat="server" Value="0" />

            <asp:Label ID="lblMensaje" runat="server" ForeColor="Green" Visible="false" Style="margin-bottom: 15px; display: block;" />

            <div class="form-row">
                <label for="<%= txtNombre.ClientID %>">Nombre:</label>
                <asp:TextBox ID="txtNombre" runat="server" MaxLength="100" />
                <asp:RequiredFieldValidator ID="rfvNombre" runat="server" ControlToValidate="txtNombre" 
                    ErrorMessage="El nombre es obligatorio." ForeColor="Red" Display="Dynamic" />
            </div>

            <div class="form-row">
                <label for="<%= txtFechaNacimiento.ClientID %>">Fecha de Nacimiento (YYYY-MM-DD):</label>
                <asp:TextBox ID="txtFechaNacimiento" runat="server" TextMode="Date" />
                <asp:RequiredFieldValidator ID="rfvFechaNacimiento" runat="server" ControlToValidate="txtFechaNacimiento" 
                    ErrorMessage="La fecha de nacimiento es obligatoria." ForeColor="Red" Display="Dynamic" />
            </div>

            <div class="form-row">
                <label for="<%= ddlSexo.ClientID %>">Sexo:</label>
                <asp:DropDownList ID="ddlSexo" runat="server">
                    <asp:ListItem Text="Seleccione" Value="" />
                    <asp:ListItem Text="Masculino" Value="M" />
                    <asp:ListItem Text="Femenino" Value="F" />
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvSexo" runat="server" ControlToValidate="ddlSexo" 
                    ErrorMessage="El sexo es obligatorio." ForeColor="Red" InitialValue="" Display="Dynamic" />
            </div>

            <asp:Button ID="btnGuardar" runat="server" Text="Guardar" OnClick="btnGuardar_Click" CssClass="btn-guardar" />

        </div>
    </form>
</body>
</html>