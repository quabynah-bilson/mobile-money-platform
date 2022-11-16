use mongodb::{options::ClientOptions, options::ResolverConfig, Client};

pub async fn connect() -> Result<Client, mongodb::error::Error> {
    // parse connection string
    let client_uri = String::from("mongodb+srv://crowder:dKMHTrv9Ms9F6dZJ@cluster0.17ikbye.mongodb.net/q-money?retryWrites=true&w=majority");
    let client_options =
        ClientOptions::parse_with_resolver_config(&client_uri, ResolverConfig::cloudflare())
            .await?;

    // get a handle to the deployment
    let client = Client::with_options(client_options)?;
    return Ok(client);
}
