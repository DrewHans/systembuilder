# How to setup an Oracle DB connection

### Prerequisite Steps
Step 0: Make sure you have Java installed.
Step 1: Download the Oracle Instant Client: https://www.oracle.com/database/technologies/instant-client.html
Step 2: Set the Environment Variable: OCI_LIB64 = C:\User\nyancat\bin\instantclient_21_7
Step 3: Open Dbeaver, click on Database at the top, and open the Driver Manager.
Step 4: In driver manager, select Oracle, select the Libraries tab, and then hit the "Download/Update" button.

### Establishing the connection
Step 1: Open Dbeaver, click on Database at the top, and select "New Database Connection".
Step 2: Select Oracle in the menu then hit Next.
Step 3: Enter the following fields with the correct information:
- Host: can be localhost or a server domain
- Database: usually the name of the database on the server (ORCL by default) and whether it's an SID or Service Name
- Port Number: 1521 is the default
- Authenticaion: can be OS auth or the db username / password / role (Normal, SYSDBA, SYSOPER)
- Client: should be the path to the Oracle Instant Client folder (the value of OCI_LIB64 variable above)
Step 4: Hit Finish and pay attention for any connection errors.
Step 5: If the connection succeeds, try running a SELECT query against it.

---

Note: make sure the paths are correct for Windows PCs (use \ slashes).
