for i in Hp*.html; do
	sed -ne '273p;274p;275p' "$i" >> results.txt
done
# sed -ne '273p;274p;275p' Keep/Hp*.html >> results.txt
