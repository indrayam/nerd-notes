# keytool

### Import Custom Root CA Cert

The steps assume that you already have the custom root CA Cert in the PEM format. Reference [Article](https://connect2id.com/blog/importing-ca-root-cert-into-jvm-trust-store)

```bash
{
# Convert it into DER format (which the Java keytool utility can understand)
openssl x509 -in ca.pem -inform pem -out ca.der -outform der

# Use the keytool to print it out and validate the root cert
keytool -v -printcert -file ca.der

# Import the root certificate into the JVM trust store (assuming the default store password is changeit)
sudo keytool -importcert -alias spinnaker -keystore $JAVA_HOME/jre/lib/security/cacerts -storepass changeit -file ca.der

# Verify that the root certificate has been imported
keytool -keystore "$JAVA_HOME/jre/lib/security/cacerts" -storepass changeit -list | grep spinnaker
}

```
Print a cert:

```bash
keytool -printcert -v -file global-bundle.pem
```
