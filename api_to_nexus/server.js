const express = require('express');
const puppeteer = require('puppeteer');
const axios = require('axios');
const fs = require('fs');

const app = express();
const port = 8081;

app.get('/skyrimse/:mod_id/:file_id/download', async (req, res) => {
    const modId = req.params.mod_id;
    const fileId = req.params.file_id;

    try {
        const downloadLink = await downloadMod('skyrimspecialedition', modId, fileId);

        // Download the mod file
        const response = await axios({
            method: 'get',
            url: downloadLink,
            responseType: 'stream',
        });

        // Set the appropriate headers for the file
        res.setHeader('Content-disposition', `attachment; filename=mod_${modId}.zip`);
        res.setHeader('Content-type', 'application/zip');

        // Pipe the file stream to the response
        response.data.pipe(res);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
});

async function downloadMod(skyrim, modId, fileId) {
    //const browser = await puppeteer.launch({ headless: true });
    const browser = await puppeteer.launch(
        {
            executablePath: '/etc/profiles/per-user/rucadi/bin/brave', // Replace with the path to your Chrome executable
            userDataDir: '/home/rucadi/.config/BraveSoftware/Brave-Browser', // Replace with the path to your user data directory
            headless: true, // Run in headless mode
        })
        ;
    const page = await browser.newPage();

    await page.setViewport({ width: 1920, height: 1080 });

    const allCookies = [
        {
            "name": "_app_session",
            "value": "mDrbQkA3kDS68ICnNWoSSX6bIVIQTAGuYGRyJFr9CdFB2gC0zi8FVnOIU4nEIrWayBMVSeo0%2Ffy%2FYEonanWdBL%2FCdOaSbPNbQtNA6ft%2B7TNmOpjJxpKtohKIvUiazTGY7wOvpgpSsgZOG1a4X3omUU%2BOcTxDlIyTbeZf3r0YHGwRJunpqe0TOgcBTDyfir9nodvPj8N%2BvclxAYmBZ%2F8tjipoNT%2FH8sOKEs0lpVZ9kaLhwn9hc%2F6F%2Fp9TsNGAwyKBpH83GXHAdsuX74pI1%2BVLJ0RPPsAFLoEEYKI5lTQCb3MGjNt120OoGLaCLpFDVY78Gnlvg8tvJNs39ibIYbdV73kKNrMpvyILrKvHNZW1zO8%2F0y2kNe39LKafsOzhCG%2F6nfO7L2NOjTuMz%2FenUEGg3y5ap60GSZuCccb6qAt8bOIhdRe8itLTbqcNtXzjBjefzx2hzJS0%2BDMKTR%2FCuR6eaDhZdCwFOsGQ3RzZkZnSTKr13WbfsAQvvTSDAGoVcRiZ6keLu2LfppcQ3BF1lpizyjz5rkQjTUWZOImvEr0hVzlsq0SyVZZdv2lS8ND80x0HaF5MvAjmMBB4m5JuW%2FJ8Wum%2FZxNFolrE%2FwEUigF7wzQkS5DmM0WMd8cufsseSfsNWwws6X4Ka0tYZnxuuNwvBvldLrKWKghWE%2B23ZrSmlEfNBqZ9KJCT%2BOwrTuWMLMVMGlHsTcXXMfCrQf%2Bbxhs7stWEMExkeQ%3D%3D--Xu%2FCYcN9LXyf%2Bxf7--FF3B%2F7rZGRE6xe95sAEQiA%3D%3D",
            "domain": ".nexusmods.com",
            "path": "/",
            "httpOnly": true,
            "secure": true,
            "expires": 1701106427.705752,
            "sameSite": "Lax"
        },
        {
            "name": "jwt_fingerprint",
            "value": "f705c78ef97b67ee5fd7d8b723edcccc",
            "domain": ".nexusmods.com",
            "path": "/",
            "httpOnly": true,
            "secure": true,
            "expires": -1
        },
        {
            "name": "member_id",
            "value": "39578925",
            "domain": ".nexusmods.com",
            "path": "/",
            "httpOnly": true,
            "secure": true,
            "expires": 1715448827.949764
        },
        {
            "name": "pass_hash",
            "value": "34bb3af01ded3d21dc2cad09f355458f",
            "domain": ".nexusmods.com",
            "path": "/",
            "httpOnly": true,
            "secure": true,
            "expires": 1715448827.949786
        },
        {
            "name": "sid_develop",
            "value": "%7B%22mechanism%22%3A%22defuse_compact%22%2C%22ciphertext%22%3A%223vUCAGmI6L5GBHQLOnws5wotsQOapa4-DdfOVxjTGqW8OWel3mRZUcYZC10CcQmVCeQD0yhaje2cmkBRX-3i5RiDChDx6ld4z39gdK1bBGAFhzeRDelGqlvpyNZObCHgi-ZWKepU6d3PGljgB0LX92GT-6rbmFr24Xa1O3yFuOaiemCuYi6fp1JutRIBP18JZsaUPOjDGF5klx9IqKmp013LopkoOA3WL8GLfz8kGxzGmlUhE9KYZAWlpbw2hyp0RHsJR1G32Nj7v7nO0CfIeGsX3Rdctcpztq0zhLnPfF4NcUYL9gj6sIQ7L2DYElyfFwXH-o3veG69rlOh1So2c884pgRsM5WAZpnSGjVETlXN1ajz9LTMysWlIBCbZS981Ft07XVHyXL0z5ue0VHiHuEi3fph4qnLDYnfYkLtHYoyy2Gem4eA0eyC19I03XjY7tbl7lkTTjTsGTAGVBO00XALkQ5oO0v3G0dsKNwXTN-FZYK-U-6VrYC4tjn5ry6l87CB-U9fJUiBVppdsKzzF1olky7VdthsldXAJIiA8kFkR99rL9ofrYRj-tlENwCf3EONT_NMQz43lTFbaG1oTkY5IE5QufKByoe_gMZDAeCIufbiJiuCcCZazD9gZmcmZJUfBNH9HnYJPcB-HVF5YJyjs-Cr1yGfBJrIoAOcpLSHoApUfKlr-I-NmNRWzzBTAHBBcv42asuNQqNSIsbxmDB5qUtwUUsyQvluXbxo9tCEgi57lXaAKTH_P3t13NPVM4pC9clKrI9u_doCitmp3ktHFDBuW3rtzitzXDfa7X7EQdS_BsDnf1pBlU-SqvWgsVNzwqLpSNCJo7B-o9QnHna1OW3qacVNLX4f0-Qm-trKg6WmUEwza9vN1lPillXFIGVXdOCUlQhUhX4foWznCpdAj6MHgTXpqYk7lar5zZCaanzGAZ76YGqeqizpB_dZkg%22%7D",
            "domain": ".nexusmods.com",
            "path": "/",
            "httpOnly": true,
            "secure": true,
            "expires": 1715448827.949823
        },
        {
            "name": "cf_clearance",
            "value": "AexcSgFSO4CejmXGBHDYz3C.nXITKgGImZJrtUI_msg-1699915656-0-1-446e3b31.1595914c.136f64d1-0.2.1699915656",
            "domain": ".nexusmods.com",
            "path": "/",
            "httpOnly": true,
            "secure": true,
            "expires": 1715467656.585064
        },
        {
            "name": "_pk_id.1.3564",
            "value": "eccc06235e893862.1699712128.",
            "domain": "www.nexusmods.com",
            "path": "/",
            "httpOnly": false,
            "secure": false,
            "expires": 1700520707.491092,
            "sameSite": "Lax"
        },
        {
            "name": "fwroute",
            "value": "1699896810.38.46.754557|b295758090068ae543818c1ba2aeea3e",
            "domain": "www.nexusmods.com",
            "path": "/",
            "httpOnly": true,
            "secure": false,
            "expires": 1700069609.62364
        },
        {
            "name": "_pk_ref.1.3564",
            "value": "%5B%22%22%2C%22%22%2C1699913633%2C%22https%3A%2F%2Fsearch.brave.com%2F%22%5D",
            "domain": "www.nexusmods.com",
            "path": "/",
            "httpOnly": false,
            "secure": false,
            "expires": 1700518432.867714,
            "sameSite": "Lax"
        },
        {
            "name": "_pk_ses.1.3564",
            "value": "1",
            "domain": "www.nexusmods.com",
            "path": "/",
            "httpOnly": false,
            "secure": false,
            "expires": 1699917707,
            "sameSite": "Lax"
        },
        {
            "name": "ab",
            "value": "0|1699915956",
            "domain": "www.nexusmods.com",
            "path": "/",
            "httpOnly": false,
            "secure": false,
            "expires": 1699915956
        }
    ];

    //await context.overridePermissions('https://www.nexusmods.com', ['downloads']);
    await page.setCookie(...allCookies)
    // You may need to customize the URL based on the structure of the Nexus Mods website
    const modPageUrl = `https://www.nexusmods.com/${skyrim}/mods/${modId}?tab=files&file_id=${fileId}`;
    console.log(modPageUrl)
    
    await page.goto(modPageUrl);
    
    await page._client().send('Page.setDownloadBehavior', {
        behavior: 'allow',
        downloadPath: '/home/rucadi/nexusdownloads',
      });

      await page.evaluate(() => {
        window.scrollTo(0, document.body.scrollHeight);
      });
    await page.screenshot({
    path: '/home/rucadi/nexusdownloads/screenshot.jpg'
    });
    await page.waitForSelector('#slowDownloadButton');
    await page.click('#slowDownloadButton'),
    
}

app.listen(port, () => {
    console.log(`API server is running at http://localhost:${port}`);
});
