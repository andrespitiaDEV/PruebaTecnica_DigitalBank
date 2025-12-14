using PruebaTecnica.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Linq;

namespace PruebaTecnica.Data
{
    public class UsuarioDAL
    {
        private readonly string _connectionString =
            ConfigurationManager.ConnectionStrings["ConexionDB"].ConnectionString;

        private const string SP_CRUD_USUARIO = "SP_CRUD_Usuario";

        public bool ExecuteCrud(Usuario usuario, string operacion)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                using (SqlCommand command = new SqlCommand(SP_CRUD_USUARIO, connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    SqlParameter returnValue = command.Parameters.Add("@ReturnVal", SqlDbType.Int);
                    returnValue.Direction = ParameterDirection.ReturnValue;

                    command.Parameters.AddWithValue("@Operacion", operacion);
                    if (operacion != "A")
                    {
                        command.Parameters.AddWithValue("@IdUsuario", usuario.IdUsuario);
                    }
                    else
                    {
                        command.Parameters.AddWithValue("@IdUsuario", DBNull.Value);
                    }

                    command.Parameters.AddWithValue("@Nombre", usuario.Nombre ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@FechaNacimiento",
                        (usuario.FechaNacimiento == DateTime.MinValue) ? (object)DBNull.Value : usuario.FechaNacimiento);
                    command.Parameters.AddWithValue("@Sexo", usuario.Sexo == '\0' ? (object)DBNull.Value : usuario.Sexo);

                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                        int spResult = (int)returnValue.Value;
                        return spResult == 1;
                    }
                    catch (SqlException ex)
                    {
                        throw new Exception("Error al ejecutar el CRUD de Usuario: " + ex.Message, ex);
                    }
                }
            }
        }

        public List<Usuario> ConsultarTodos()
        {
            List<Usuario> usuarios = new List<Usuario>();

            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                using (SqlCommand command = new SqlCommand(SP_CRUD_USUARIO, connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@Operacion", "C");

                    try
                    {
                        connection.Open();
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                usuarios.Add(new Usuario
                                {
                                    IdUsuario = Convert.ToInt32(reader["IdUsuario"]),
                                    Nombre = reader["Nombre"].ToString(),
                                    FechaNacimiento = Convert.ToDateTime(reader["FechaNacimiento"]),
                                    Sexo = reader["Sexo"].ToString()[0]
                                });
                            }
                        }
                    }
                    catch (SqlException ex)
                    {
                        throw new Exception("Error al consultar usuarios: " + ex.Message, ex);
                    }
                }
            }
            return usuarios;
        }
    }
}