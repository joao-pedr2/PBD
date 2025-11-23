<?php
// Força o navegador a entender que é UTF-8
header('Content-Type: text/html; charset=utf-8');

// 1. CONEXÃO COM O BANCO DE DADOS
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "falls_car_db";

$conn = new mysqli($servername, $username, $password, $dbname);

// Garante que a comunicação com o banco seja em UTF-8
$conn->set_charset("utf8");

if ($conn->connect_error) {
    die("Falha na conex&atilde;o: " . $conn->connect_error);
}

$mensagem = "";

// ---------------------------------------------------------
// 2. LÓGICA DE EXCLUSÃO
// ---------------------------------------------------------
if (isset($_GET['deletar'])) {
    $id_para_deletar = (int)$_GET['deletar'];

    $sql_delete = "DELETE FROM CARRO WHERE id_carro = $id_para_deletar";
    
    if ($conn->query($sql_delete) === TRUE) {
        $mensagem = "<p class='msg-sucesso'>Carro removido com sucesso!</p>";
    } else {
        $mensagem = "<p class='msg-erro'>N&atilde;o foi poss&iacute;vel excluir. O carro pode estar vinculado a um contrato.</p>";
    }
}

// ---------------------------------------------------------
// 3. LÓGICA DE INSERÇÃO
// ---------------------------------------------------------
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $placa = $_POST['placa'];
    $chassi = $_POST['chassi'];
    $id_categoria = $_POST['id_categoria'];
    $id_loja = $_POST['id_loja'];
    
    $id_carro_novo = rand(200, 999); 

    $sql_insert = "INSERT INTO CARRO (id_carro, placa, chassi, nivel_combustivel, id_status, id_categoria, id_loja_atual) 
                   VALUES ('$id_carro_novo', '$placa', '$chassi', '1.0', '10', '$id_categoria', '$id_loja')";

    if ($conn->query($sql_insert) === TRUE) {
        $mensagem = "<p class='msg-sucesso'>Carro placa <strong>$placa</strong> cadastrado!</p>";
    } else {
        $mensagem = "<p class='msg-erro'>Erro ao cadastrar: " . $conn->error . "</p>";
    }
}
?>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Sistema Falls Car - Gest&atilde;o</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; margin: 0; background-color: #f0f2f5; }
        .container { max-width: 900px; margin: 30px auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); }
        h1 { color: #2c3e50; text-align: center; }
        h2 { color: #34495e; border-bottom: 2px solid #eee; padding-bottom: 10px; margin-top: 30px;}
        
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; color: #555; }
        input, select { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 5px; box-sizing: border-box; }
        button { background-color: #27ae60; color: white; padding: 12px; border: none; border-radius: 5px; cursor: pointer; width: 100%; font-size: 16px; }
        button:hover { background-color: #219150; }

        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background-color: #2980b9; color: white; }
        tr:hover { background-color: #f1f1f1; }
        
        .btn-excluir { background-color: #c0392b; color: white; padding: 5px 10px; text-decoration: none; border-radius: 4px; font-size: 14px; }
        .btn-excluir:hover { background-color: #a93226; }

        .msg-sucesso { background-color: #d4edda; color: #155724; padding: 10px; border-radius: 5px; margin-bottom: 10px;}
        .msg-erro { background-color: #f8d7da; color: #721c24; padding: 10px; border-radius: 5px; margin-bottom: 10px;}
    </style>
</head>
<body>

<div class="container">
    <h1>Sistema Falls Car</h1>
    <?php echo $mensagem; ?>

    <h2>Novo Carro</h2>
    <form method="POST" action="index.php">
        <div class="form-group">
            <label>Placa:</label> <input type="text" name="placa" required maxlength="10">
        </div>
        <div class="form-group">
            <label>Chassi:</label> <input type="text" name="chassi" required maxlength="30">
        </div>
        <div class="form-group">
            <label>Categoria:</label>
            <select name="id_categoria">
                <option value="1">B&aacute;sico</option>
                <option value="2">SUV</option>
                <option value="3">Luxo</option>
            </select>
        </div>
        <div class="form-group">
            <label>Loja Atual:</label>
            <select name="id_loja">
                <option value="1">Loja Congonhas (SP)</option>
            </select>
        </div>
        <button type="submit">Cadastrar Ve&iacute;culo</button>
    </form>

    <h2>Frota Dispon&iacute;vel</h2>
    <?php
    $sql = "SELECT C.id_carro, C.placa, C.chassi, CAT.nome_categoria, L.nome_loja, DS.valor_status
            FROM CARRO C
            JOIN CATEGORIA CAT ON C.id_categoria = CAT.id_categoria
            JOIN LOJA L ON C.id_loja_atual = L.id_loja
            JOIN DOMINIO_STATUS DS ON C.id_status = DS.id_status
            ORDER BY C.id_carro DESC";

    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        echo "<table>";
        echo "<tr><th>Placa</th><th>Categoria</th><th>Loja</th><th>Status</th><th>A&ccedil;&atilde;o</th></tr>";
        while($row = $result->fetch_assoc()) {
            echo "<tr>";
            echo "<td>" . $row["placa"] . "</td>";
            
            // Corrige acentos vindos do banco se necessário (opcional, mas bom pra garantir)
            $categoria = ($row["nome_categoria"] == 'BASICO') ? 'B&aacute;sico' : $row["nome_categoria"];
            
            echo "<td>" . $categoria . "</td>";
            echo "<td>" . $row["nome_loja"] . "</td>";
            echo "<td>" . $row["valor_status"] . "</td>";
            
            echo "<td>
                    <a href='index.php?deletar=" . $row["id_carro"] . "' 
                       class='btn-excluir'
                       onclick=\"return confirm('Tem certeza que deseja remover este carro?');\">
                       Excluir
                    </a>
                  </td>";
            echo "</tr>";
        }
        echo "</table>";
    } else {
        echo "<p>Nenhum carro encontrado.</p>";
    }
    $conn->close();
    ?>
</div>

</body>
</html>
