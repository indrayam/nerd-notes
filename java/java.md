# java

#### Find out the heap details of the Java Unix process
jmap -heap <process_id>

#### How to add deal with self-signed certs?
[Source](https://confluence.atlassian.com/display/STASHKB/SSLHandshakeException+-+unable+to+find+valid+certification+path+to+requested+target)

Chances are when you call the HTTPS endpoint using Java, you get an error like:<br>
`SSLHandshakeException - unable to find valid certification path to requested target`

Whenever Java based app attempts to connect to an external service over over SSL, it will only be able to connect to it if it can trust the certificate loaded there. As an application written in Java, the way trust is handled is that you have a keystore (typically `$JAVA_HOME/lib/security/cacerts` or `JAVA_HOME/jre/lib/security/cacerts`) or also known as the trust store. This contains a list of all the known CA certificates and Java will only trust certificates that are signed by those CA certificate or public certificates that exist within that keystore.

Hence, this error will usually happen if:
A self-signed certificate or a certificate that is not signed by a CA authority is being used to secure the external service.
A certificate is loaded in an Apache Proxy between the Stash and the other application.

**Resolution**<br>
Export the target application's SSL Certificate, import it into the  JVM's TrustStore and re-run the application

`openssl s_client -connect <hostname>:443 < /dev/null | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > public.crt`

If you get errors like:

```bash
gethostbyname failure
connect:errno=0
```

Use IP address of the host as opposed to DNS name

followed by

`$JAVA_HOME/bin/keytool -import -alias <server_name> -keystore $JAVA_HOME/jre/lib/security/cacerts -file public.crt`

Default Password: `changeit`

[Source](http://stackoverflow.com/questions/875467/java-client-certificates-over-https-ssl)
If for any reason you cannot import to the default "JKS" type keystore provided by Sun, you can always run the above command and instead of passing `-keystore $JAVA_HOME/jre/lib/security/cacerts`, you can pass `-keystore <localfile>.keystore`

For example:
`keytool -import -alias <hostname> -file gridserver.crt -storepass $PASS -keystore <hostname>.keystore`

And then, when running the Java App from the command line, pass this to the JVM:
`java -Djavax.net.ssl.keyStore=pathToKeystore -Djavax.net.ssl.keyStorePassword=123456 ...`

New [Source](http://www.mkyong.com/webservices/jax-ws/suncertpathbuilderexception-unable-to-find-valid-certification-path-to-requested-target/) from Vivek

