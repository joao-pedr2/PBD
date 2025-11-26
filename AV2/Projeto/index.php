<?php
ob_start();
mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
header('Content-Type: text/html; charset=utf-8');

try {
    $conn = new mysqli("localhost", "root", "", "falls_car_db");
    $conn->set_charset("utf8");
} catch (Exception $e) { die("Erro crítico: " . $e->getMessage()); }

$mensagem = "";
$pagina_atual = isset($_GET['pagina']) ? $_GET['pagina'] : 'dashboard';

if (isset($_POST['realizar_locacao'])) {
    try {
        $id_carro = (int)$_POST['id_carro_aluguel'];
        $dias = (int)$_POST['dias_contratados'];
        $tem_motorista = !empty($_POST['id_motorista']);
        $id_motorista = $_POST['id_motorista'];

        $col = "preco_" . $dias . "_dias";
        $res = $conn->query("SELECT TP.id_preco, TP.$col as base FROM CARRO C JOIN TABELA_PRECO TP ON C.id_categoria = TP.id_categoria WHERE C.id_carro = $id_carro")->fetch_assoc();
        
        if(!$res) throw new Exception("Preço não configurado.");
        
        $total = $res['base'] + ($tem_motorista ? 200 : 0);
        $id_contrato = rand(10000, 99999);
        $cod = "CTR-" . $id_contrato;
        $sql_mot = $tem_motorista ? "'$id_motorista'" : "NULL";

        $conn->query("INSERT INTO CONTRATO_LOCACAO (id_contrato, codigo_contrato, data_retirada, dias_contratados, canal_reserva, valor_diaria_acordado, valor_acessorios, valor_total, id_status, id_cliente, id_carro, id_loja_retirada, id_motorista, id_preco) VALUES ('$id_contrato', '$cod', NOW(), '$dias', 'Site', '{$res['base']}', '0', '$total', '20', '1', '$id_carro', '1', $sql_mot, '{$res['id_preco']}')");
        $conn->query("INSERT INTO TRANSACAO_PAGAMENTO VALUES ('".rand(1000,9999)."', 'PGT-WEB', '$total', NOW(), 30, '$id_contrato')");
        $conn->query("UPDATE CARRO SET id_status = 11 WHERE id_carro = $id_carro");
        
        header("Location: index.php?msg=sucesso_locacao&cod=$cod&val=$total"); exit;
    } catch (Exception $e) { $mensagem = "<div class='alert alert-error'>Erro: " . $e->getMessage() . "</div>"; }
}

if (isset($_POST['cadastrar_carro'])) {
    try {
        $img_padrao = 'https://img.freepik.com/fotos-gratis/carro-compacto-branco-isolado_114579-4346.jpg';
        
        $conn->query("INSERT INTO CARRO (id_carro, fabricante, modelo, placa, chassi, nivel_combustivel, id_status, id_categoria, id_loja_atual, url_imagem) VALUES ('".rand(1000,9999)."', '{$_POST['fabricante']}', '{$_POST['modelo']}', '{$_POST['placa']}', '{$_POST['chassi']}', '1.0', '10', '{$_POST['id_categoria']}', '{$_POST['id_loja']}', '$img_padrao')");
        header("Location: index.php?msg=sucesso_cadastro"); exit;
    } catch (Exception $e) { $mensagem = "<div class='alert alert-error'>Erro: " . $e->getMessage() . "</div>"; }
}

if (isset($_GET['devolver_carro'])) {
    $conn->query("UPDATE CARRO SET id_status = 10 WHERE id_carro = " . (int)$_GET['devolver_carro']);
    header("Location: index.php?msg=sucesso_devolucao"); exit;
}

if (isset($_GET['msg'])) {
    if ($_GET['msg'] == 'sucesso_locacao') $mensagem = "<div class='alert alert-success'><i class='fas fa-check-circle'></i> Contrato <strong>" . htmlspecialchars($_GET['cod']) . "</strong> confirmado. R$ " . htmlspecialchars($_GET['val']) . "</div>";
    if ($_GET['msg'] == 'sucesso_cadastro') $mensagem = "<div class='alert alert-success'><i class='fas fa-check-circle'></i> Veículo salvo.</div>";
    if ($_GET['msg'] == 'sucesso_devolucao') $mensagem = "<div class='alert alert-success'><i class='fas fa-undo'></i> Veículo devolvido.</div>";
}

function getLojas($conn) {
    $res = $conn->query("SELECT id_loja, nome_loja FROM LOJA ORDER BY nome_loja");
    while($row = $res->fetch_assoc()) echo "<option value='{$row['id_loja']}'>{$row['nome_loja']}</option>";
}
?>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Falls Car - Enterprise</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .frota-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 20px; }
        .car-card { background: white; border-radius: 12px; border: 1px solid #e2e8f0; overflow: hidden; transition: transform 0.2s; display: flex; flex-direction: column;}
        .car-card:hover { transform: translateY(-5px); box-shadow: 0 10px 15px -3px rgba(0,0,0,0.1); border-color: var(--primary); }
        
        .car-image-container {
            width: 100%;
            height: 180px;
            background-color: #fff;
            border-bottom: 1px solid #f1f5f9;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }
        .car-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
            object-position: center;
        }

        .car-body { padding: 20px; flex: 1; display: flex; flex-direction: column; }
        .car-title { font-size: 1.1rem; font-weight: 700; color: #1e293b; margin-bottom: 5px; }
        .car-plate { font-family: monospace; background: #f1f5f9; padding: 2px 6px; border-radius: 4px; font-size: 0.85rem; color: #64748b; display: inline-block; margin-bottom: 15px;}
        
        .car-infos { margin-bottom: 20px; }
        .info-item { display: flex; align-items: center; gap: 8px; font-size: 0.9rem; color: #475569; margin-bottom: 6px; }
        
        .car-footer { margin-top: auto; padding-top: 15px; border-top: 1px solid #e2e8f0; display: flex; justify-content: space-between; align-items: center; }
        .price-box small { display: block; font-size: 0.75rem; color: #94a3b8; }
        .price-val { font-size: 1.2rem; font-weight: 800; color: var(--primary); }
        
        .nav-item { text-decoration: none; }
        
        .car-placeholder {
            width: 100%; height: 180px; background: #f1f5f9; display: flex; align-items: center; justify-content: center; color: #cbd5e1;
        }
    </style>
</head>
<body>

<div class="app-container">
    <nav class="sidebar">
        <div class="brand"><i class="fas fa-layer-group"></i> FallsCar</div>
        <div class="nav-links">
            <a href="index.php?pagina=dashboard" class="nav-item <?php echo ($pagina_atual == 'dashboard') ? 'active' : ''; ?>"><i class="fas fa-chart-pie"></i> Visão Geral</a>
            <a href="index.php?pagina=frota" class="nav-item <?php echo ($pagina_atual == 'frota') ? 'active' : ''; ?>"><i class="fas fa-car"></i> Minha Frota (Livre)</a>
        </div>
    </nav>

    <main class="main-content">
        <header class="header-page">
            <h2><?php echo ucfirst($pagina_atual); ?></h2>
            <div class="user-profile"><span>Admin</span><div class="avatar">AD</div></div>
        </header>

        <?php if($mensagem) echo $mensagem; ?>

        <?php if($pagina_atual == 'dashboard'): ?>
            <div class="stats-row">
                <?php
                $total = $conn->query("SELECT COUNT(*) as c FROM CARRO")->fetch_assoc()['c'];
                $livres = $conn->query("SELECT COUNT(*) as c FROM CARRO WHERE id_status = 10")->fetch_assoc()['c'];
                $rec = $conn->query("SELECT SUM(valor_total) as s FROM CONTRATO_LOCACAO")->fetch_assoc()['s'];
                ?>
                <div class="stat-card"><span class="stat-title">Total Frota</span><span class="stat-value"><?php echo $total; ?></span></div>
                <div class="stat-card"><span class="stat-title">Disponíveis</span><span class="stat-value" style="color: var(--success)"><?php echo $livres; ?></span></div>
                <div class="stat-card"><span class="stat-title">Receita</span><span class="stat-value" style="color: var(--primary)">R$ <?php echo number_format($rec, 2, ',', '.'); ?></span></div>
            </div>

            <div class="dashboard-grid">
                <div class="col-left">
                    <div class="card">
                        <div class="card-header"><h3><i class="fas fa-key"></i> Nova Locação</h3></div>
                        <form method="POST" action="index.php">
                            <div class="form-group"><label>Veículo Disponível</label><select name="id_carro_aluguel" required><?php $res = $conn->query("SELECT C.id_carro, C.fabricante, C.modelo, C.placa, CAT.nome_categoria FROM CARRO C JOIN CATEGORIA CAT ON C.id_categoria = CAT.id_categoria WHERE C.id_status = 10"); if($res->num_rows > 0) { while($c = $res->fetch_assoc()) { $nome = $c['fabricante'] ? "{$c['fabricante']} {$c['modelo']}" : "Genérico"; echo "<option value='{$c['id_carro']}'>$nome - {$c['placa']} ({$c['nome_categoria']})</option>"; } } else { echo "<option disabled selected>Sem veículos disponíveis</option>"; } ?></select></div>
                            <div class="row-2">
                                <div class="form-group"><label>Duração</label><select name="dias_contratados"><option value="7">7 Dias</option><option value="15">15 Dias</option><option value="30">30 Dias</option></select></div>
                                <div class="form-group"><label>Motorista</label><select name="id_motorista"><option value="">Sem Motorista</option><?php $mots = $conn->query("SELECT id_motorista, nome FROM MOTORISTA"); while($m = $mots->fetch_assoc()) echo "<option value='{$m['id_motorista']}'>{$m['nome']}</option>"; ?></select></div>
                            </div>
                            <button type="submit" name="realizar_locacao" class="btn-primary">Confirmar Contrato</button>
                        </form>
                    </div>
                </div>
                <div class="col-right">
                    <div class="card">
                        <div class="card-header"><h3><i class="fas fa-plus"></i> Novo Veículo</h3></div>
                        <form method="POST" action="index.php">
                            <div class="row-2 form-group"><input type="text" name="fabricante" placeholder="Marca" required><input type="text" name="modelo" placeholder="Modelo" required></div>
                            <div class="row-2 form-group"><input type="text" name="placa" placeholder="Placa" maxlength="8" required><input type="text" name="chassi" placeholder="Chassi" maxlength="20" required></div>
                            <div class="form-group"><label>Categoria</label><select name="id_categoria"><option value="1">Básico</option><option value="2">Intermediário</option><option value="3">SUV</option><option value="4">Luxo</option></select></div>
                            <div class="form-group"><label>Loja</label><select name="id_loja"><?php getLojas($conn); ?></select></div>
                            <button type="submit" name="cadastrar_carro" class="btn-secondary">Salvar</button>
                        </form>
                    </div>
                </div>
            </div>

        <?php elseif($pagina_atual == 'frota'): ?>
            
            <div class="frota-grid">
                <?php
                $sql_frota = "SELECT C.fabricante, C.modelo, C.placa, C.url_imagem, CAT.nome_categoria, L.nome_loja, TP.preco_7_dias 
                              FROM CARRO C 
                              JOIN CATEGORIA CAT ON C.id_categoria = CAT.id_categoria
                              JOIN LOJA L ON C.id_loja_atual = L.id_loja
                              JOIN TABELA_PRECO TP ON C.id_categoria = TP.id_categoria
                              WHERE C.id_status = 10";
                
                $res_frota = $conn->query($sql_frota);
                
                if($res_frota->num_rows > 0) {
                    while($car = $res_frota->fetch_assoc()) {
                        $img = (!empty($car['url_imagem'])) ? $car['url_imagem'] : 'https://img.freepik.com/fotos-gratis/carro-compacto-branco-isolado_114579-4346.jpg';
                        
                        echo "
                        <div class='car-card'>
                            <div class='car-image-container'>
                                <img src='$img' class='car-image' alt='Foto do Veículo' onerror=\"this.style.display='none'; this.parentNode.innerHTML='<div class=\'car-placeholder\'><i class=\'fas fa-car fa-3x\'></i></div>'\">
                            </div>
                            
                            <div class='car-body'>
                                <div class='car-title'>{$car['fabricante']} {$car['modelo']}</div>
                                <span class='car-plate'>{$car['placa']}</span>
                                
                                <div class='car-infos'>
                                    <div class='info-item'><i class='fas fa-tag'></i> {$car['nome_categoria']}</div>
                                    <div class='info-item'><i class='fas fa-map-marker-alt'></i> {$car['nome_loja']}</div>
                                </div>
                                
                                <div class='car-footer'>
                                    <div class='price-box'>
                                        <small>Semanal a partir de</small>
                                        <span class='price-val'>R$ " . number_format($car['preco_7_dias'], 2, ',', '.') . "</span>
                                    </div>
                                    <a href='index.php?pagina=dashboard' class='btn-primary btn-sm'>Alugar</a>
                                </div>
                            </div>
                        </div>";
                    }
                } else {
                    echo "<div class='alert alert-warning full-width'>Nenhum veículo disponível na frota no momento.</div>";
                }
                ?>
            </div>

        <?php endif; ?>

    </main>
</div>

</body>
</html>
