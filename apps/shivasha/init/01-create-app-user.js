// Runs only when MongoDB initializes an empty data directory.
const appDatabase = process.env.MONGO_APP_DATABASE;
const appUsername = process.env.MONGO_APP_USERNAME;
const appPassword = process.env.MONGO_APP_PASSWORD;

if (!appDatabase || !appUsername || !appPassword) {
  throw new Error("MONGO_APP_DATABASE, MONGO_APP_USERNAME and MONGO_APP_PASSWORD are required");
}

const appDb = db.getSiblingDB(appDatabase);
appDb.createUser({
  user: appUsername,
  pwd: appPassword,
  roles: [{ role: "readWrite", db: appDatabase }]
});
print("Created the Shivasha application database user.");
