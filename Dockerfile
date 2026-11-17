# ntfy for Railway: the official image, pinned by version and digest.
# Bump the tag and digest together, and add a CHANGELOG.md entry.
FROM binwiederhier/ntfy:v2.38.1@sha256:038da2be5e668fee6d36a62884eea48975e1b71c29a56964e5298c1b9165a573

COPY start.sh /usr/local/bin/railway-start.sh
RUN chmod 0755 /usr/local/bin/railway-start.sh

# Railway sets PORT. 8080 is the default when it doesn't.
ENV PORT=8080
EXPOSE 8080

ENTRYPOINT ["/usr/local/bin/railway-start.sh"]
