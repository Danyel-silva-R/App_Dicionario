# Instruções para Publicação na Play Store

## Arquivos de Assinatura (IMPORTANTE - MANTER EM SEGURANÇA!)

### Localização dos arquivos:
- **Keystore**: `android/app/upload-keystore.jks`
- **Configuração**: `android/key.properties`
- **Senha**: `playstore/keystore_password.txt`

### Credenciais da Chave:
- **Alias**: `upload`
- **Senha**: Salva em `playstore/keystore_password.txt`
- **Validade**: 10.000 dias (~27 anos)

---

## ⚠️ AVISOS IMPORTANTES

1. **NUNCA** commite os seguintes arquivos no Git:
   - `android/key.properties`
   - `android/app/upload-keystore.jks`
   - `playstore/keystore_password.txt`

2. **FAÇA BACKUP** desses arquivos em local seguro (Google Drive, pendrive, etc.)

3. **Se perder a chave**, você NÃO poderá atualizar o app na Play Store!

---

## Como Gerar o AAB para Play Store

1. Abra o terminal na pasta do projeto

2. Execute:
   ```bash
   flutter build appbundle --release
   ```

3. O arquivo será gerado em:
   ```
   build/app/outputs/bundle/release/app-release.aab
   ```

4. Copie para a pasta playstore:
   ```powershell
   Copy-Item "build\app\outputs\bundle\release\app-release.aab" -Destination "playstore\dicionario_assurini_v1.0.0.aab"
   ```

---

## Atualizando a Versão

Antes de gerar um novo AAB, atualize a versão no `pubspec.yaml`:

```yaml
version: 1.0.0+1
```

- **1.0.0** = versionName (exibido para usuários)
- **+1** = versionCode (deve ser incrementado a cada upload)

### Exemplo de incremento:
- Primeira versão: `1.0.0+1`
- Correção de bugs: `1.0.1+2`
- Nova funcionalidade: `1.1.0+3`
- Grande atualização: `2.0.0+4`

---

## Checklist antes de publicar

- [ ] Versão incrementada no `pubspec.yaml`
- [ ] Testado em dispositivo real
- [ ] Screenshots atualizados
- [ ] Descrição do app atualizada
- [ ] Política de privacidade (se necessário)

---

## Configuração do .gitignore

Adicione ao seu `.gitignore`:

```
# Arquivos de assinatura (NÃO commitar!)
android/key.properties
android/app/upload-keystore.jks
playstore/keystore_password.txt
```
