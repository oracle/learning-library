/* NOTE: Files cannot contain empty lines (line breaks) */
/* Specify the base URL that you copied from your files in OCI Object Storage in the define base_URL line below*/
/* change idthydc0kinr to your real namespace. The name is case-sensitive. */
/* change ADWCLab to your real bucket name. The name is case-sensitive. */
/* change us-phoenix-1 to your real region name. The name is case-sensitive. */
/* you can find these values on the OCI Console .. Storage .. Object Storage screen */
set define on
define base_URL='https://objectstorage.us-phoenix-1.oraclecloud.com/n/idthydc0kinr/b/ADWCLab/o'
/* copy Channels table */
begin
 dbms_cloud.copy_data(
    table_name =>'CHANNELS',
    credential_name =>'OBJ_STORE_CRED',
    file_uri_list =>'&base_URL/chan_v3.dat',
    format => json_object('ignoremissingcolumns' value 'true', 'removequotes' value 'true')
 );
end;
/
/* copy Countries table */
begin
 dbms_cloud.copy_data(
    table_name =>'COUNTRIES',
    credential_name =>'OBJ_STORE_CRED',
    file_uri_list =>'&base_URL/coun_v3.dat',
    format => json_object('ignoremissingcolumns' value 'true', 'removequotes' value 'true')
 );
end;
/
/* Copy customers */
begin
 dbms_cloud.copy_data(
    table_name =>'CUSTOMERS',
    credential_name =>'OBJ_STORE_CRED',
    file_uri_list =>'&base_URL/cust1v3.dat',
    format => json_object('ignoremissingcolumns' value 'true', 'removequotes' value 'true', 'dateformat' value 'YYYY-MM-DD-HH24-MI-SS')
 );
end;
/
begin
 dbms_cloud.copy_data(
    table_name =>'SUPPLEMENTARY_DEMOGRAPHICS',
    credential_name =>'OBJ_STORE_CRED',
    file_uri_list =>'&base_URL/dem1v3.dat',
    format => json_object('ignoremissingcolumns' value 'true', 'removequotes' value 'true')
 );
end;
/
begin
 dbms_cloud.copy_data(
    table_name =>'SALES',
    credential_name =>'OBJ_STORE_CRED',
    file_uri_list =>'&base_URL/dmsal_v3.dat',
    format => json_object('ignoremissingcolumns' value 'true', 'removequotes' value 'true', 'dateformat' value 'YYYY-MM-DD')
 );
end;
/
begin
 dbms_cloud.copy_data(
    table_name =>'PRODUCTS',
    credential_name =>'OBJ_STORE_CRED',
    file_uri_list =>'&base_URL/prod1v3.dat',
    format => json_object('delimiter' value '|', 'quote' value '^', 'ignoremissingcolumns' value 'true', 'dateformat' value 'YYYY-MM-DD-HH24-MI-SS', 'blankasnull' value 'true')
 );
end;
/
begin
 dbms_cloud.copy_data(
    table_name =>'PROMOTIONS',
    credential_name =>'OBJ_STORE_CRED',
    file_uri_list =>'&base_URL/prom1v3.dat',
    format => json_object('ignoremissingcolumns' value 'true', 'removequotes' value 'true', 'dateformat' value 'YYYY-MM-DD-HH24-MI-SS', 'blankasnull' value 'true')
 );
end;
/
begin
 dbms_cloud.copy_data(
    table_name =>'SALES',
    credential_name =>'OBJ_STORE_CRED',
    file_uri_list =>'&base_URL/sale1v3.dat',
    format => json_object('ignoremissingcolumns' value 'true', 'removequotes' value 'true', 'dateformat' value 'YYYY-MM-DD', 'blankasnull' value 'true')
 );
end;
/
begin
 dbms_cloud.copy_data(
    table_name =>'TIMES',
    credential_name =>'OBJ_STORE_CRED',
    file_uri_list =>'&base_URL/time_v3.dat',
    format => json_object('ignoremissingcolumns' value 'true', 'removequotes' value 'true', 'dateformat' value 'YYYY-MM-DD-HH24-MI-SS', 'blankasnull' value 'true')
 );
end;
/
begin
 dbms_cloud.copy_data(
    table_name =>'COSTS',
    credential_name =>'OBJ_STORE_CRED',
    file_uri_list =>'&base_URL/costs.dat',
    format => json_object('ignoremissingcolumns' value 'true', 'dateformat' value 'YYYY-MM-DD', 'blankasnull' value 'true')
 );
end;
/
