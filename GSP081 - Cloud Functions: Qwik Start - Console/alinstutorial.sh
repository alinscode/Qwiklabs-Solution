gcloud services enable run.googleapis.com

sleep 10

mkdir quicklab && cd quicklab

cat > index.js <<EOF_END
/**
 * Responds to any HTTP request.
 *
 * @param {!express:Request} req HTTP request context.
 * @param {!express:Response} res HTTP response context.
 */
exports.GCFunction = (req, res) => {
    let message = req.query.message || req.body.message || 'Subscribe to Alins Tutorial on YouTube';
    res.status(200).send(message);
  };
  
EOF_END


cat > package.json <<EOF_END
{