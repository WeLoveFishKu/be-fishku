const express = require("express");
const router = express.Router();

const db = require("../../config/config");
const { GetOutput, PostOutput, ErrorResponse } = require("../../utils/output");

// wika
router.post("/transaksi/input", async (req, res) => {
	try {
		const externalID = req.body.externalID;
		const id_consumer = req.body.id_consumer;
		const id_ordering = req.body.id_ordering;
		const created = req.body.created;
		const paid_at = req.body.paid_at;
		const status = req.body.status;
		const id_seller = req.body.id_seller;

		await updateWallet({ userId: id_seller, orderId: id_ordering });
		const query = ` INSERT INTO transaction (id_external, id_consumer, dates_transaction, dates_payed, id_ordering, status) VALUES ('${externalID}', '${id_consumer}',  '${created}', '${paid_at}','${id_ordering}', '${status}')`;

		await PostOutput(query, res);
	} catch (err) {
		return ErrorResponse(err, res);
	}
});

router.get("/transaksi/:id_consumer", async (req, res) => {
	try {
		const id_consumer = req.params.id_consumer;

		const query = `SELECT * FROM transaction where id_consumer = '${id_consumer}'`;
		await GetOutput(query, res);
	} catch (err) {
		return ErrorResponse(err, res);
	}
});

const updateWallet = async ({ userId, orderId }) => {
	const queryProductId = `SELECT id_fish FROM detail_ordering WHERE id_ordering = ${orderId};`;
	db.query(queryProductId, (err, result) => {
		if (err) throw Error(err);
		const productId = result[0].id_fish;

		const queryProduct = `SELECT price FROM fish WHERE id = ${productId};`;
		db.query(queryProduct, (err, resultProduct) => {
			if (err) throw Error(err);
			const totalPrice = resultProduct[0].price;

			const queryUser = `SELECT my_wallet FROM seller WHERE id = ${userId};`;
			db.query(queryUser, (err, resultUser) => {
				if (err) throw Error(err);
				const currentWallet = resultUser[0].my_wallet;
				const newWallet = parseFloat(currentWallet) + parseFloat(totalPrice);

				const queryUpdateUser = `UPDATE seller SET my_wallet = '${+newWallet}' WHERE id = '${userId}';`;
				db.query(queryUpdateUser, (err, result) => {
					if (err) throw Error(err);
					console.log(result);
				});
			});
		});
	});
};

module.exports = router;
