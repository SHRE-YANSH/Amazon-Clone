const express = require('express');
const adminRouter = express.Router();
const {Product} = require("../models/product");
const admin = require('../middleware/admin');
adminRouter.post('/admin/add-product', admin, async(req, res) => {
    try{
        const {name, description, images, quantity, price, category} = req.body;
        let product = new Product({name, description, images, quantity, price, category});
        product = await product.save();
    }catch(e){res.status(500).json({error: e.message})}
});

adminRouter.get('/admin/get-products', admin, async(req, res) => {
    try{
        const products = await Product.find({});
        res.json(products);
    }catch(e){res.status(500).json({error: e.message})}
});

adminRouter.delete('/admin/delete-product/:name', admin, async(req, res) => {
    try{
        const deleteProduct = await Product.findOneAndDelete({name: req.params.name});
        res.json(deleteProduct);
    }
    catch(e){res.status(500).json({error: e.message})}
});

module.exports = adminRouter;