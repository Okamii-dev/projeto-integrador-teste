package control;

import dao.UsuarioDAO;
import java.util.List;
import model.Usuario;

public class Usuario_ctrl {

    public List<Usuario> select_all() {
        UsuarioDAO dao = new UsuarioDAO();
        return dao.read();
    }

    public boolean validarDados(Usuario usu) {
        return !usu.getNome().isEmpty()
                && !usu.getLogin().isEmpty()
                && !usu.getSenha().isEmpty()
                && !usu.getEmail().isEmpty()
                && !usu.getTelefone().isEmpty();
    }

    public boolean salvarDados(Usuario usu) {
        boolean resp = false;

        if (validarDados(usu)) {
            UsuarioDAO dao = new UsuarioDAO();

            if (usu.getIdusuario()!= 0) {

                resp = dao.update(usu);

            } else {
                resp = dao.create(usu);

            }
        }
        return resp;
    }

    public boolean delete(int id) {
        UsuarioDAO dao = new UsuarioDAO();
        return dao.delete(id);
    }

}
