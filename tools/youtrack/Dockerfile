FROM openjdk

WORKDIR /opt/youtrack

ENV VERSION 2017.1.30973
RUN mkdir -p /opt/youtrack/data /opt/youtrack/backup
RUN wget https://download-cf.jetbrains.com/charisma/youtrack-$VERSION.jar -O youtrack.jar

EXPOSE 80
CMD \
    java \
    -Xmx1g \
    -Dorg.tanukisoftware.wrapper.WrapperSimpleApp.waitForStartMain=true \
    -Dorg.tanukisoftware.wrapper.WrapperSimpleApp.maxStartMainWait=300 \
    -XX:MaxPermSize=128m \
    -XX:+HeapDumpOnOutOfMemoryError \
    -XX:+UseConcMarkSweepGC \
    -XX:+DisableExplicitGC \
    -XX:SoftRefLRUPolicyMSPerMB=10000 \
    -XX:+UseBiasedLocking \
    -Djava.awt.headless=true \
    -Xss4m \
    -Dcatalina.base=/home/youtrack/standalone \
    -Ddatabase.location=/opt/youtrack/data \
    -Ddatabase.backup.location=/opt/youtrack/backup \
    -Djetbrains.dnq.cachePercent=25 \
    -Djetbrains.dnq.sharedCache=false \
    -Djetbains.webr.uiQueryCancellingPolicyTimeout=80000 \
    -Djetbrains.dnq.fairLatches=false \
    -Djetbrains.dnq.readUncommittedForCachingThread=true \
    -Djetbrains.youtrack.disableBrowser=true \
    -jar youtrack.jar 80
