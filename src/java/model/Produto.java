package model;

public class Produto {
    
    private int idproduto;
    private String produto;
    private String descricao;
    private int preco;
    private String contato;
    private int idusuario;

    public Produto() {
    }

    public Produto(int idproduto, String produto, String descricao, int preco, String contato, int idusuario) {
        this.idproduto = idproduto;
        this.produto = produto;
        this.descricao = descricao;
        this.preco = preco;
        this.contato = contato;
        this.idusuario = idusuario;
    }

    public int getIdproduto() {
        return idproduto;
    }

    public void setIdproduto(int idproduto) {
        this.idproduto = idproduto;
    }

    public String getProduto() {
        return produto;
    }

    public void setProduto(String produto) {
        this.produto = produto;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public int getPreco() {
        return preco;
    }

    public void setPreco(int preco) {
        this.preco = preco;
    }

    public String getContato() {
        return contato;
    }

    public void setContato(String contato) {
        this.contato = contato;
    }

    public int getIdusuario() {
        return idusuario;
    }

    public void setIdusuario(int idusuario) {
        this.idusuario = idusuario;
    }
    
}
