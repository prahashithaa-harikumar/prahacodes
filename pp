import React, { useState } from 'react';

const CustomerApplicationForm = () => {
  const [customerType, setCustomerType] = useState('');
  const [formData, setFormData] = useState({
    bankAccountId: '',
    fullName: '',
    dob: '',
    address: '',
    contactNumber: '',
    aadharNumber: '',
    panCardNumber: '',
    email: '',
    monthlyIncome: '',
    product: 'Silver',
    idProofFile: null,
    aadharFile: null,
    panCardFile: null,
    profile: 'New',
  });

  const [errors, setErrors] = useState({});

  const validate = () => {
    const newErrors = {};
    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    const aadharPattern = /^\d{12}$/;
    const panPattern = /^[A-Z]{5}[0-9]{4}[A-Z]{1}$/;
    const contactNumberPattern = /^\d{10}$/;

    if (!customerType) newErrors.customerType = 'Customer Type is required';
    if (customerType === 'existing' && !formData.bankAccountId)
      newErrors.bankAccountId = 'Bank Account ID is required';

    if (customerType === 'new') {
      if (!formData.fullName) newErrors.fullName = 'Full Name is required';
      if (!formData.dob) newErrors.dob = 'Date of Birth is required';
      if (!formData.address) newErrors.address = 'Address is required';
      if (!formData.contactNumber) {
        newErrors.contactNumber = 'Contact Number is required';
      } else if (!contactNumberPattern.test(formData.contactNumber)) {
        newErrors.contactNumber = 'Contact Number must be 10 digits';
      }
      if (!formData.aadharNumber) {
        newErrors.aadharNumber = 'Aadhar Number is required';
      } else if (!aadharPattern.test(formData.aadharNumber)) {
        newErrors.aadharNumber = 'Aadhar Number must be 12 digits';
      }
      if (!formData.panCardNumber) {
        newErrors.panCardNumber = 'PAN Card Number is required';
      } else if (!panPattern.test(formData.panCardNumber)) {
        newErrors.panCardNumber = 'PAN Card Number is invalid';
      }
      if (!formData.email) {
        newErrors.email = 'Email is required';
      } else if (!emailPattern.test(formData.email)) {
        newErrors.email = 'Email is invalid';
      }
      if (!formData.monthlyIncome) newErrors.monthlyIncome = 'Monthly Income is required';
    }

    if (!formData.idProofFile) newErrors.idProofFile = 'ID Proof is required';
    if (!formData.aadharFile) newErrors.aadharFile = 'Aadhar file is required';
    if (!formData.panCardFile) newErrors.panCardFile = 'PAN Card file is required';

    return newErrors;
  };

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setFormData({
      ...formData,
      [name]: value,
    });
    setErrors({
      ...errors,
      [name]: '',
    });
  };

  const handleFileChange = (e) => {
    const { name, files } = e.target;
    setFormData({
      ...formData,
      [name]: files[0],
    });
    setErrors({
      ...errors,
      [name]: '',
    });
  };

  const handleSubmit = () => {
    const validationErrors = validate();
    if (Object.keys(validationErrors).length > 0) {
      setErrors(validationErrors);
      alert('Please fix the errors in the form.');
      return;
    }
    alert('Customer data submitted successfully!');
  };

  const handleSave = () => {
    const textData = `
      Customer Type: ${customerType}
      Bank Account ID: ${formData.bankAccountId}
      Full Name: ${formData.fullName}
      Date of Birth: ${formData.dob}
      Address: ${formData.address}
      Contact Number: ${formData.contactNumber}
      Aadhar Number: ${formData.aadharNumber}
      PAN Card Number: ${formData.panCardNumber}
      Email: ${formData.email}
      Monthly Income: ${formData.monthlyIncome}
      Product: ${formData.product}
    `;

    const blob = new Blob([textData], { type: 'text/plain' });
    const link = document.createElement('a');
    link.href = URL.createObjectURL(blob);
    link.download = 'CustomerApplication.txt';
    link.click();
  };

  return (
    <div className="container mx-auto p-8">
      <h1 className="text-2xl font-bold mb-4">CC Application Form</h1>

      <div className="mb-4">
        <label className="block text-gray-700">Is Customer New or Existing?</label>
        <select
          name="customerType"
          className="w-full p-2 border border-gray-300 rounded mt-2"
          value={customerType}
          onChange={(e) => setCustomerType(e.target.value)}
        >
          <option value="">Select</option>
          <option value="new">New</option>
          <option value="existing">Existing</option>
        </select>
        {errors.customerType && <p className="text-red-500">{errors.customerType}</p>}
      </div>

      {customerType === 'existing' && (
        <div className="mb-4">
          <label className="block text-gray-700">Bank Account ID</label>
          <input
            type="text"
            name="bankAccountId"
            value={formData.bankAccountId}
            onChange={handleInputChange}
            className="w-full p-2 border border-gray-300 rounded mt-2"
          />
          {errors.bankAccountId && <p className="text-red-500">{errors.bankAccountId}</p>}
        </div>
      )}

      {customerType === 'new' && (
        <>
          <div className="mb-4">
            <label className="block text-gray-700">Full Name</label>
            <input
              type="text"
              name="fullName"
              value={formData.fullName}
              onChange={handleInputChange}
              className="w-full p-2 border border-gray-300 rounded mt-2"
            />
            {errors.fullName && <p className="text-red-500">{errors.fullName}</p>}
          </div>

          <div className="mb-4">
            <label className="block text-gray-700">Date of Birth</label>
            <input
              type="date"
              name="dob"
              value={formData.dob}
              onChange={handleInputChange}
              className="w-full p-2 border border-gray-300 rounded mt-2"
            />
            {errors.dob && <p className="text-red-500">{errors.dob}</p>}
          </div>

          <div className="mb-4">
            <label className="block text-gray-700">Address</label>
            <input
              type="text"
              name="address"
              value={formData.address}
              onChange={handleInputChange}
              className="w-full p-2 border border-gray-300 rounded mt-2"
            />
            {errors.address && <p className="text-red-500">{errors.address}</p>}
          </div>

          <div className="mb-4">
            <label className="block text-gray-700">Contact Number</label>
            <input
              type="text"
              name="contactNumber"
              value={formData.contactNumber}
              onChange={handleInputChange}
              className="w-full p-2 border border-gray-300 rounded mt-2"
            />
            {errors.contactNumber && <p className="text-red-500">{errors.contactNumber}</p>}
          </div>

          <div className="mb-4">
            <label className="block text-gray-700">Aadhar Number</label>
            <input
              type="text"
              name="aadharNumber"
              value={formData.aadharNumber}
              onChange={handleInputChange}
              className="w-full p-2 border border-gray-300 rounded mt-2"
            />
            {errors.aadharNumber && <p className="text-red-500">{errors.aadharNumber}</p>}
          </div>

          <div className="mb-4">
            <label className="block text-gray-700">PAN Card Number</label>
            <input
              type="text"
              name="panCardNumber"
              value={formData.panCardNumber}
              onChange={handleInputChange}
              className="w-full p-2 border border-gray-300 rounded mt-2"
            />
            {errors.panCardNumber && <p className="text-red-500">{errors.panCardNumber}</p>}
          </div>
          <div className="mb-4">
            <label className="block text-gray-700">Email</label>
            <input
              type="email"
              name="email"
              value={formData.email}
              onChange={handleInputChange}
              className="w-full p-2 border border-gray-300 rounded mt-2"
              pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$"
              required
            />
            {errors.email && <p className="text-red-500">{errors.email}</p>}
          </div>

          <div className="mb-4">
            <label className="block text-gray-700">Monthly Income</label>
            <input
              type="number"
              name="monthlyIncome"
              value={formData.monthlyIncome}
              onChange={handleInputChange}
              className="w-full p-2 border border-gray-300 rounded mt-2"
              required
            />
            {errors.monthlyIncome && <p className="text-red-500">{errors.monthlyIncome}</p>}
          </div>
        </>
      )}

      <div className="mb-4">
        <label className="block text-gray-700">Product</label>
        <select
          name="product"
          className="w-full p-2 border border-gray-300 rounded mt-2"
          value={formData.product}
          onChange={handleInputChange}
        >
          <option value="Silver">Silver</option>
          <option value="Gold">Gold</option>
          <option value="Platinum">Platinum</option>
        </select>
        {errors.product && <p className="text-red-500">{errors.product}</p>}
      </div>

      <div className="mb-4">
        <label className="block text-gray-700">ID Proof (Passport)</label>
        <input
          type="file"
          name="idProofFile"
          onChange={handleFileChange}
          className="w-full p-2 border border-gray-300 rounded mt-2"
          required
        />
        {errors.idProofFile && <p className="text-red-500">{errors.idProofFile}</p>}
      </div>

      <div className="mb-4">
        <label className="block text-gray-700">Aadhar (PDF or Image)</label>
        <input
          type="file"
          name="aadharFile"
          onChange={handleFileChange}
          className="w-full p-2 border border-gray-300 rounded mt-2"
          required
        />
        {errors.aadharFile && <p className="text-red-500">{errors.aadharFile}</p>}
      </div>

      <div className="mb-4">
        <label className="block text-gray-700">PAN Card (PDF or Image)</label>
        <input
          type="file"
          name="panCardFile"
          onChange={handleFileChange}
          className="w-full p-2 border border-gray-300 rounded mt-2"
          required
        />
        {errors.panCardFile && <p className="text-red-500">{errors.panCardFile}</p>}
      </div>

      <div className="flex space-x-4">
        <button
          onClick={handleSubmit}
          className="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600"
        >
          Submit
        </button>
        <button
          onClick={handleSave}
          className="bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600"
        >
          Save
        </button>
        <button
          onClick={() => window.location.reload()}
          className="bg-red-500 text-white px-4 py-2 rounded hover:bg-red-600"
        >
          Cancel
        </button>
      </div>
    </div>
  );
};
          