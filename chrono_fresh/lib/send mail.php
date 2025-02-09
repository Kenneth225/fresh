<?php
// Connexion à la base de données
$host = 'localhost'; // ou ton hôte
$dbname = 'ta_base_de_donnees'; // ton nom de base de données
$username = 'ton_utilisateur'; // ton utilisateur MySQL
$password = 'ton_mot_de_passe'; // ton mot de passe MySQL

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Erreur de connexion : " . $e->getMessage());
}

// Récupérer l'adresse e-mail depuis un formulaire
if (isset($_POST['email'])) {
    $email = $_POST['email'];

    // Vérifier si l'adresse e-mail est valide
    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        die("L'adresse e-mail est invalide.");
    }

    // Générer un code numérique aléatoire
    $code = rand(100000, 999999);

    // Enregistrer l'e-mail et le code dans la base de données
    $stmt = $pdo->prepare("INSERT INTO utilisateurs (email, code_authentification) VALUES (?, ?)");
    $stmt->execute([$email, $code]);

    // Envoyer l'email
    $subject = "Code d'authentification";
    $message = "Voici votre code d'authentification : $code";
    $headers = "From: no-reply@tonsite.com"; // Remplace par ton adresse e-mail

    if (mail($email, $subject, $message, $headers)) {
        echo "Un e-mail contenant votre code d'authentification a été envoyé.";
    } else {
        echo "Erreur lors de l'envoi de l'e-mail.";
    }
}
?>

<!-- Formulaire pour saisir l'adresse e-mail -->
<form method="POST">
    <label for="email">Entrez votre adresse e-mail :</label>
    <input type="email" id="email" name="email" required>
    <button type="submit">Envoyer le code</button>
</form>
