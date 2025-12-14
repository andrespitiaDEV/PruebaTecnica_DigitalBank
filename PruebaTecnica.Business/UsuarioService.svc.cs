using PruebaTecnica.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using PruebaTecnica.Data;

namespace PruebaTecnica.Business
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "Service1" in code, svc and config file together.
    // NOTE: In order to launch WCF Test Client for testing this service, please select Service1.svc or Service1.svc.cs at the Solution Explorer and start debugging.
    public class UsuarioService : IUsuarioService
    {
        private readonly UsuarioDAL _dal = new UsuarioDAL();

        public bool Agregar(Usuario usuario)
        {
            return _dal.ExecuteCrud(usuario, "A");
        }

        public bool Modificar(Usuario usuario)
        {
            return _dal.ExecuteCrud(usuario, "M");
        }

        public List<Usuario> Consultar()
        {
            return _dal.ConsultarTodos();
        }

        public bool Eliminar(int idUsuario)
        {
            return _dal.ExecuteCrud(new Usuario { IdUsuario = idUsuario }, "E");
        }
    }
}
