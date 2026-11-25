</main>
<footer class="footer">
    <p><?= htmlspecialchars(App::MARCA, ENT_QUOTES, 'UTF-8') ?> &bull; Sistema de Control de Asistencia QR</p>
</footer>
<script src="<?= htmlspecialchars($assetBase, ENT_QUOTES, 'UTF-8') ?>/assets/js/app.js"></script>
<?php /* Captura la ubicacion en los formularios marcados con data-geo */ ?>
<script src="<?= htmlspecialchars($assetBase, ENT_QUOTES, 'UTF-8') ?>/assets/js/geo.js"></script>
</body>
</html>
