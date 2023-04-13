const express = require('express');
const productRouter = express.Router();
const {Product} = require("../models/product");
const auth = require('../middleware/auth')
productRouter.get('/api/products', auth, async(req, res) => {
    try{
        const products = await Product.find({category: req.query.category});
        res.json(products);
    }catch(e){res.status(500).json({error: e.message})}
});

productRouter.get('/api/products/search/:name', auth, async(req, res) => {
    try{
        const products = await Product.find({name : {$regex: req.params.name, $options: 'i'}});
        res.json(products);
    }catch(e){res.status(500).json({error: e.message})}
});

productRouter.get('/api/deal-of-day', auth, async(req, res) => {
    try{
        let products = await Product.find({});
        products =  products.sort((a,b) => {
            let aSum = 0;
            let bSum = 0;
            for(let i=0; i<a.ratings.length; i++){
                aSum += a.ratings[i].rating;
            }
            for(let i=0; i<b.ratings.length; i++){
                bSum += b.ratings[i].rating;
            }

            return aSum < bSum ? 1: -1;
        });

        res.json(products[0]);
    }catch(e){res.status(500).json({error: e.message})}
});

productRouter.post('/api/rate-product', auth, async(req, res) => {
    try{
        const {id, rating} = req.body
        let products = await Product.findById(id);
        for(let i=0; i<products.ratings.length; i++){
            if(products.ratings[i].userId == req.user){
                products.ratings.splice(i, 1);
                break;
            }
        }
        const ratingSchema = {
            userId: req.user,
            rating,
        }
        products.ratings.push(ratingSchema);
        products = await products.save();
        res.json(products);
    }catch(e){res.status(500).json({error: e.message})}
});
module.exports = productRouter;