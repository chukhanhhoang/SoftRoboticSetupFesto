module rounded_square( W, R ) {
	translate( [ R, R, 0 ] )
		minkowski() {
			square( W - 2 * R );
			circle( R );
		}
}