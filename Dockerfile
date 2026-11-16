# ntfy for Railway: the official image, pinned by version and digest.
# Bump the tag and digest together, and add a CHANGELOG.md entry.
FROM binwiederhier/ntfy:v2.38.0@sha256:771309aecfce18d8fe2bfb8069994ddd6be6ca6ccdd7badace3d791a0045ff0d

COPY start.sh /usr/local/bin/railway-start.sh
RUN chmod 0755 /usr/local/bin/railway-start.sh

# Railway sets PORT. 8080 is the default when it doesn't.
ENV PORT=8080
EXPOSE 8080

ENTRYPOINT ["/usr/local/bin/railway-start.sh"]
